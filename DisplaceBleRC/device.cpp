// Copyright (C) 2013 BlackBerry Limited. All rights reserved.
// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "device.h"

#include <QBluetoothDeviceInfo>
#include <QBluetoothUuid>

#include <QDebug>
#include <QMetaObject>
#include <QTimer>

#if QT_CONFIG(permissions)
#include <QPermissions>

#include <QGuiApplication>
#endif

#define PRINT_TRACE() qDebug() << Q_FUNC_INFO

#pragma pack(push,1)
struct MousePkt {
    quint8  type;   // 0x01=move, 0x02=btn
    float   dx;     // move delta X (float32)
    float   dy;     // move delta Y (float32)
    quint8  btn;    // 0..4
    quint8  down;   // 0/1
    qint16  dwheel;
    qint16  hwheel;
    char    key1;
    quint8  key2;
};
#pragma pack(pop)

QByteArray encodeMsg(const QVariantMap &m) {
    MousePkt p{};
    QString type = m.value("type").toString();

    if (type=="move") {
        p.type = 1;
    } else if (type=="btn") {
        p.type = 2;
    } else if (type=="scroll") {
        p.type = 3;
    } else if (type=="home") {
        p.type = 4;
    } else if (type=="goback") {
        p.type = 5;
    } else if (type=="search") {
        p.type = 6;
    } else if (type=="play_pause") {
        p.type = 7;
    } else if (type=="poweron") {
        p.type = 8;
    } else if (type=="poweroff") {
        p.type = 9;
    } else if (type=="key") {
        p.type = 10;
    } else if (type=="heartbeat") {
        p.type = 100;
    }

    // p.t_ms = qToLittleEndian<quint32>(quint32(m.value("t").toDouble()*1000.0));

    if (p.type==1) {
        p.dx = float(m.value("dx").toDouble());
        p.dy = float(m.value("dy").toDouble());
    } else if (p.type==2) {
        auto mapBtn = [](const QString &s)->quint8{
            if (s=="left") return 0;
            if (s=="right") return 1;
            if (s=="middle") return 2;
            if (s=="back") return 3;
            if (s=="forward") return 4;
            return 0;
        };
        p.btn  = mapBtn(m.value("btn").toString());
        p.down = m.value("down").toBool() ? 1 : 0;
    } else if (p.type==3) {
        p.dwheel = m.value("dwheel").toInt();
        p.hwheel = m.value("hwheel").toInt();
    } else if (p.type == 10) {
        QByteArray buf = m.value("key1").toString().toUtf8();
        if (buf.length() > 0) {
            p.key1 = buf.at(0);
        }

        p.key2 = m.value("key2").toInt();
    }

    return QByteArray(reinterpret_cast<const char*>(&p), sizeof(p));
}

using namespace Qt::StringLiterals;

Device::Device(QObject *parent)
{
    PRINT_TRACE();

    //! [les-devicediscovery-1]
    discoveryAgent = new QBluetoothDeviceDiscoveryAgent(this);
    discoveryAgent->setLowEnergyDiscoveryTimeout(25000);
    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::deviceDiscovered, this, &Device::addDevice);
    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::errorOccurred, this, &Device::deviceScanError);
    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::finished, this, &Device::deviceScanFinished);
    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::canceled, this, &Device::deviceScanFinished);
    //! [les-devicediscovery-1]

    // setUpdate(u"Search"_s);
}

Device::~Device()
{
    PRINT_TRACE();

    qDeleteAll(devices);
    qDeleteAll(m_services);
    qDeleteAll(m_characteristics);
    devices.clear();
    m_services.clear();
    m_characteristics.clear();
}

void Device::startDeviceDiscovery()
{
    PRINT_TRACE();

    if (devices.size() > 0) {
        qDeleteAll(devices);
        devices.clear();
        emit devicesUpdated();
    }

    discoveryAgent->start(QBluetoothDeviceDiscoveryAgent::LowEnergyMethod);

    if (discoveryAgent->isActive()) {
        m_deviceScanState = true;
        Q_EMIT stateChanged();
    }
}

void Device::stopDeviceDiscovery()
{
    PRINT_TRACE();

    if (discoveryAgent->isActive()) {
        discoveryAgent->stop();
    }
}

void Device::addDevice(const QBluetoothDeviceInfo &info)
{
    PRINT_TRACE();

    if (info.coreConfigurations() & QBluetoothDeviceInfo::LowEnergyCoreConfiguration) {
        auto devInfo = new DeviceInfo(info);
        auto it = std::find_if(devices.begin(), devices.end(), [devInfo](DeviceInfo *dev) {
            return devInfo->getAddress() == dev->getAddress();
        });

        if (it == devices.end()) {
            devices.append(devInfo);
        } else {
            auto oldDev = *it;
            *it = devInfo;
            delete oldDev;
        }
        emit devicesUpdated();
    }
}

void Device::deviceScanFinished()
{
    m_deviceScanState = false;
    emit stateChanged();
}

QVariant Device::getDevices()
{
    return QVariant::fromValue(devices);
}

QVariant Device::getServices()
{
    return QVariant::fromValue(m_services);
}

QVariant Device::getCharacteristics()
{
    return QVariant::fromValue(m_characteristics);
}

void Device::scanServices(const QString &address)
{
    // We need the current device for service discovery.

    for (auto d: std::as_const(devices)) {
        if (auto device = qobject_cast<DeviceInfo *>(d)) {
            if (device->getAddress() == address) {
                currentDevice.setDevice(device->getDevice());
                break;
            }
        }
    }

    if (!currentDevice.getDevice().isValid()) {
        qWarning() << "Not a valid device";
        return;
    }

    {
        qDeleteAll(m_characteristics);
        m_characteristics.clear();
        emit characteristicsUpdated();
        qDeleteAll(m_services);
        m_services.clear();
        emit servicesUpdated();
    }

    if (controller && m_previousAddress != currentDevice.getAddress()) {
        controller->disconnectFromDevice();
        delete controller;
        controller = nullptr;
    }

    if (!controller) {
        // Connecting signals and slots for connecting to LE services.
        controller = QLowEnergyController::createCentral(currentDevice.getDevice(), this);
        connect(controller, &QLowEnergyController::connected, this, &Device::deviceConnected);
        connect(controller, &QLowEnergyController::errorOccurred, this, &Device::errorReceived);
        connect(controller, &QLowEnergyController::disconnected, this, &Device::deviceDisconnected);
        connect(controller, &QLowEnergyController::serviceDiscovered, this, &Device::addLowEnergyService);
        connect(controller, &QLowEnergyController::discoveryFinished, this, &Device::serviceScanDone);
    }

    controller->connectToDevice();

    m_previousAddress = currentDevice.getAddress();
}

void Device::addLowEnergyService(const QBluetoothUuid &serviceUuid)
{
    QLowEnergyService *service = controller->createServiceObject(serviceUuid);
    if (!service) {
        qWarning() << "Cannot create service for uuid";
        return;
    }

    auto serv = new ServiceInfo(service);

    {
        m_services.append(serv);
    }

    emit servicesUpdated();
}

void Device::serviceScanDone()
{
    // force UI in case we didn't find anything
    if (m_services.isEmpty())
        emit servicesUpdated();
}

void Device::connectToService(const QString &uuid)
{
    QLowEnergyService *service = nullptr;
    for (auto s: std::as_const(m_services)) {
        auto serviceInfo = qobject_cast<ServiceInfo *>(s);
        if (!serviceInfo)
            continue;

        if (serviceInfo->getUuid() == uuid) {
            service = serviceInfo->service();
            break;
        }
    }

    if (!service)
        return;

    {
        qDeleteAll(m_characteristics);
        m_characteristics.clear();
        emit characteristicsUpdated();
    }

    if (service->state() == QLowEnergyService::RemoteService) {
        connect(service, &QLowEnergyService::stateChanged,
                this, &Device::serviceDetailsDiscovered);
        service->discoverDetails();
        return;
    }

    //discovery already done
    const QList<QLowEnergyCharacteristic> chars = service->characteristics();
    for (const QLowEnergyCharacteristic &ch : chars) {
        auto cInfo = new CharacteristicInfo(ch);

        m_characteristics.append(cInfo);
    }

    connect(service, &QLowEnergyService::characteristicChanged, this, [](const QLowEnergyCharacteristic &characteristic, const QByteArray &newValue) {
        qDebug() << "characteristicChanged:" << newValue;
    });

    connect(service, &QLowEnergyService::characteristicRead, this, [](const QLowEnergyCharacteristic &info, const QByteArray &value) {
        qDebug() << "characteristicRead:" << value;
    });

    QTimer::singleShot(0, this, &Device::characteristicsUpdated);
}

void Device::deviceConnected()
{
    QLowEnergyConnectionParameters params;
    params.setIntervalRange(1, 6);
    params.setLatency(0);
    params.setSupervisionTimeout(500); // 500 * 10ms = 5s
    controller->requestConnectionUpdate(params);

    connected = true;
    controller->discoverServices();
}

void Device::errorReceived(QLowEnergyController::Error /*error*/)
{
    qWarning() << "Error: " << controller->errorString();
}

void Device::disconnectFromDevice()
{
    // UI always expects disconnect() signal when calling this signal
    // TODO what is really needed is to extend state() to a multi value
    // and thus allowing UI to keep track of controller progress in addition to
    // device scan progress

    if (controller->state() != QLowEnergyController::UnconnectedState)
        controller->disconnectFromDevice();
    else
        deviceDisconnected();
}

void Device::enableNotification(const QString &sUuid, const QString &cUuid)
{
    qDebug() << "enableNotification()";

    QLowEnergyService *service = nullptr;
    for (auto s: std::as_const(m_services)) {
        auto serviceInfo = qobject_cast<ServiceInfo *>(s);
        if (!serviceInfo)
            continue;

        if (serviceInfo->getUuid() == sUuid) {
            service = serviceInfo->service();
            break;
        }
    }

    if (!service) {
        qDebug() << "Service not available";
        return;
    }

    bool found = false;
    QLowEnergyCharacteristic characteristic;
    for (auto c: std::as_const(m_characteristics)) {
        auto characteristicInfo = qobject_cast<CharacteristicInfo *>(c);
        if (!characteristicInfo)
            continue;

        auto uuid = characteristicInfo->getUuid();
        qDebug() << "UUID:" << uuid;

        if (uuid == cUuid) {
            characteristic = characteristicInfo->getCharacteristic();
            found = true;
            break;
        }
    }

    if (!found) {
        qDebug() << "Characteristic not available";
        return;
    }

    auto cccd = characteristic.descriptor(characteristic.uuid());
    if (!cccd.isValid()) {
        qDebug() << "No CCCD for characteristic";
        return;
    }

    // 0x0100 = notifications enabled
    service->writeDescriptor(cccd, QByteArray::fromHex("0100"));
}

void Device::writeData(const QString &sUuid, const QString &cUuid, const QVariantMap &obj)
{
    QLowEnergyService *service = nullptr;
    for (auto s: std::as_const(m_services)) {
        auto serviceInfo = qobject_cast<ServiceInfo *>(s);
        if (!serviceInfo)
            continue;

        if (serviceInfo->getUuid() == sUuid) {
            service = serviceInfo->service();
            break;
        }
    }

    if (!service) {
        qDebug() << "Service not available";
        return;
    }

    bool found = false;
    QLowEnergyCharacteristic characteristic;
    for (auto c: std::as_const(m_characteristics)) {
        auto characteristicInfo = qobject_cast<CharacteristicInfo *>(c);
        if (!characteristicInfo)
            continue;

        auto uuid = characteristicInfo->getUuid();
        qDebug() << "UUID:" << uuid;

        if (uuid == cUuid) {
            characteristic = characteristicInfo->getCharacteristic();
            found = true;
            break;
        }
    }

    if (!found) {
        qDebug() << "Characteristic not available";
        return;
    }

    auto buf = encodeMsg(obj);
    service->writeCharacteristic(characteristic, buf, QLowEnergyService::WriteWithoutResponse);
    qDebug() << "Sent";
}

void Device::deviceDisconnected()
{
    qWarning() << "Disconnect from device";
    emit disconnected();
}

void Device::serviceDetailsDiscovered(QLowEnergyService::ServiceState newState)
{
    if (newState != QLowEnergyService::RemoteServiceDiscovered) {
        // do not hang in "Scanning for characteristics" mode forever
        // in case the service discovery failed
        // We have to queue the signal up to give UI time to even enter
        // the above mode
        if (newState != QLowEnergyService::RemoteServiceDiscovering) {
            QMetaObject::invokeMethod(this, "characteristicsUpdated",
                                      Qt::QueuedConnection);
        }
        return;
    }

    auto service = qobject_cast<QLowEnergyService *>(sender());
    if (!service)
        return;

    const QList<QLowEnergyCharacteristic> chars = service->characteristics();
    for (const QLowEnergyCharacteristic &ch : chars) {
        auto cInfo = new CharacteristicInfo(ch);

        m_characteristics.append(cInfo);
    }

    emit characteristicsUpdated();
}

void Device::deviceScanError(QBluetoothDeviceDiscoveryAgent::Error error)
{
    if (error == QBluetoothDeviceDiscoveryAgent::PoweredOffError) {
        // setUpdate(u"The Bluetooth adaptor is powered off, power it on before doing discovery."_s);
    } else if (error == QBluetoothDeviceDiscoveryAgent::InputOutputError) {
        // setUpdate(u"Writing or reading from the device resulted in an error."_s);
    } else {
        static QMetaEnum qme = discoveryAgent->metaObject()->enumerator(
                    discoveryAgent->metaObject()->indexOfEnumerator("Error"));
        // setUpdate(u"Error: "_s + QLatin1StringView(qme.valueToKey(error)));
    }

    m_deviceScanState = false;
    emit stateChanged();
}

bool Device::state()
{
    return m_deviceScanState;
}

bool Device::hasControllerError() const
{
    return (controller && controller->error() != QLowEnergyController::NoError);
}
