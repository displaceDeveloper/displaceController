import 'dart:async';

import 'package:displacerc/core/ble/ble_state.dart';
import 'package:displacerc/core/logger.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import './ble_service.dart';

class BleServiceFake implements BleService {
  late BleState state;
  final _controller = StreamController<BleState>.broadcast();

  BleServiceFake() {
    _setState(BleInitialized());
  }

  @override
  bool isProduction() {
    return false;
  }

  @override
  Stream<BleState> watchState() => _controller.stream;

  @override
  Future<void> connect({String? deviceId, String? tvCode}) async {
    _setState(BleConnecting(remoteId: deviceId ?? "FAKE_DEVICE_ID"));

    await Future.delayed(const Duration(seconds: 3));

    _setState(BleConnected(remoteId: deviceId ?? "FAKE_DEVICE_ID"));

    await Future.delayed(const Duration(seconds: 3));

    var remoteId = DeviceIdentifier("Abcde");
    var serviceUuid = Guid("1234");
    var characteristicUuid = Guid("2345");

    _setState(
      BlePaired(
        remoteId: remoteId.toString(),
        rxCharacteristic: BluetoothCharacteristic(
          remoteId: remoteId,
          serviceUuid: serviceUuid,
          characteristicUuid: characteristicUuid,
        ),
        txCharacteristic: BluetoothCharacteristic(
          remoteId: remoteId,
          serviceUuid: serviceUuid,
          characteristicUuid: characteristicUuid,
        ),
        tvCode: tvCode ?? "000000",
        pairingCode: "123456",
        isMuted: false,
        isPoweredOn: false,
        volume: 0
      ),
    );
  }

  @override
  Future<void> disconnect() async {
    _setState(BleDisconnected());
  }

  @override
  Future<void> startScan({Duration? timeout}) async {
    logBle.info("startScan()");
  }

  @override
  Future<void> stopScan() async {
    logBle.info("stopScan()");
  }

  @override
  Stream<List<int>> subscribeToCharacteristic() {
    // TODO: implement subscribeToCharacteristic
    throw UnimplementedError();
  }

  @override
  Future<void> writeData({required List<int> data}) async {
    logBle.info("writeData() get called for ${data.length} bytes");
  }

  @override
  void clearDevices() {}

  void _setState(BleState s) {
    state = s;
    _controller.add(s);
  }

  @override
  bool isScanning() {
    return false;
  }

  @override
  void enableHeartbeat({required bool enable}) {
    logBle.info("enableHeartbeat() called with enable=$enable");
  }

  @override
  void updateDownloadPercent(int percent) {
    logBle.info("updateDownloadPercent() called with percent=$percent");
  }
}
