import 'dart:async';
import 'dart:io';
import 'dart:math' as Math;

import 'package:collection/collection.dart';
import 'package:displacerc/constants/app_info.dart';
import 'package:displacerc/core/ble/ble_state.dart';
import 'package:displacerc/core/logger.dart';
import 'package:displacerc/core/msg/msg.pb.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_volume_controller/flutter_volume_controller.dart';

import './ble_service.dart';

class BleServiceReal implements BleService {
  BleState state = BleInitialized();
  BluetoothDevice? _device;

  // Heartbeat
  Timer? _heartbeatTimer;
  Timer? _heartBeatCheck;
  DateTime _lastReceivedHeartBeat = DateTime.now();
  Stream<List<int>>? _heartbeatResponseStream;
  StreamSubscription<List<int>>? _heartbeatResponseSub;
  int _heartbeatLevel = 0;
  bool _enableHeartbeat = true;

  // Scan
  StreamSubscription<BluetoothConnectionState>? _connectionSub;
  StreamSubscription<List<ScanResult>>? _scanSub;
  List<ScanResult> _devices = [];
  bool _isScanning = false;
  bool _isInitialized = false;

  Timer? _reconnectTimer;

  final _controller = StreamController<BleState>.broadcast();

  @override
  bool isProduction() {
    return Platform.isAndroid;
  }

  @override
  Future<void> startScan({Duration? timeout}) async {
    logBle.info('Starting BLE scan');

    if (_isScanning) {
      // Already scanning
      return;
    }

    await _stopInternal();

    _isScanning = true;

    try {
      _scanSub = FlutterBluePlus.scanResults.listen(
        (results) {
          final merged = _mergeResults(_devices, results);
          _devices = merged;
        },
        onError: (e) {
          _isScanning = false;
          throw StateError("Scan error");
        },
      );

      await FlutterBluePlus.startScan(
        timeout: timeout,
        // bạn có thể thêm filter: services: [...], etc.
      );

      // NOTE: trong flutter_blue_plus, nếu truyền timeout,
      // nó sẽ tự stop sau timeout. Khi đó stream vẫn chạy,
      // nhưng isScanning thực tế là false.
      FlutterBluePlus.isScanning.listen((isScanning) {
        _isScanning = isScanning;
      });
    } catch (e) {
      _isScanning = false;
      logBle.warning('Scan error: $e');

      await _stopInternal();
    }
  }

  @override
  Future<void> stopScan() async {
    await _stopInternal();
    _isScanning = false;
  }

  @override
  void clearDevices() {
    _devices = [];
  }

  @override
  Future<void> connect({
    String? deviceId,
    required String tvCode,
    int? level,
  }) async {
    await _cleanup();

    _setState(BleConnecting(remoteId: deviceId));

    _devices.where((d) => d.advertisementData.advName.isNotEmpty).forEach((e) {
      logBle.info(
        'Found device: ${e.device.remoteId} - ${e.advertisementData.advName} (RSSI: ${e.rssi})',
      );
    });

    BluetoothDevice? device = _devices.firstWhereOrNull((dev) {
      if (deviceId != null) {
        return dev.device.remoteId == DeviceIdentifier(deviceId);
      }

      return dev.advertisementData.advName == tvCode;
    })?.device;

    if (device == null) {
      if (level == 5) {
        // Tried 5 times already, give up
        logBle.warning('Device not found after 5 attempts, giving up');
        if (_reconnectTimer != null) {
          _reconnectTimer?.cancel();
          _reconnectTimer = null;
        }
        _setState(BleFailedPairing());
        return;
      }

      if (!_isScanning) {
        logBle.info('Device not found, starting scan to find device');
        await startScan(timeout: Duration(seconds: 30));
      }

      _reconnectTimer = Timer(Duration(seconds: 3), () {
        // Run once
        logBle.info('Retrying connect after scan started');
        connect(deviceId: deviceId, tvCode: tvCode, level: (level ?? 0) + 1);
      });

      return;
    }

    logBle.info('Connecting to device: ${device.remoteId}');

    _device = device;

    if (deviceId != device.remoteId.toString()) {
      _setState(BleConnecting(remoteId: device.remoteId.toString()));
    }

    try {
      _connectionSub = device.connectionState.listen((s) {
        logSys.info('Connection state changed: $s');

        if (s == BluetoothConnectionState.connected) {
          _setState(BleConnected(remoteId: device.remoteId.toString()));
        } else if (s == BluetoothConnectionState.disconnected) {
          if (!_isInitialized) {
            // This is kind of a reset from FlutterBluePlus, ignore
            _isInitialized = true;
            return;
          }

          _setState(BleDisconnected());
        }
      });

      await device.connect(license: License.free, autoConnect: false);

      if (device.isConnected) {
        logBle.info('Discovering services on device ${device.remoteId}');

        await device.requestConnectionPriority(
          connectionPriorityRequest: ConnectionPriority.high,
        );

        final services = await device.discoverServices();
        logBle.info(
          'Discovered ${services.length} services on device ${device.remoteId}',
        );

        var service = services.firstWhereOrNull(
          (s) => s.uuid == Guid('12345678-1234-5678-1234-56789abcdef0'),
        );
        if (service == null) {
          logBle.warning(
            'Required service not found on device ${device.remoteId}',
          );
          throw StateError('Required service not found');
        }
        var rxCharacteristic = service.characteristics.firstWhereOrNull(
          (c) => c.uuid == Guid('12345678-1234-5678-1234-56789abcdef1'),
        );
        var txCharacteristic = service.characteristics.firstWhereOrNull(
          (c) => c.uuid == Guid('12345678-1234-5678-1234-56789abcdef2'),
        );
        if (rxCharacteristic == null || txCharacteristic == null) {
          logBle.warning(
            'Required characteristic not found on device ${device.remoteId}',
          );
          throw StateError('Required characteristic not found');
        }

        var current = state;
        if (current is! BleConnected) {
          throw StateError('State is not connected');
        }

        _enableHeartbeat = true;

        _setState(
          BlePaired(
            remoteId: device.remoteId.toString(),
            rxCharacteristic: rxCharacteristic,
            txCharacteristic: txCharacteristic,
            tvCode: tvCode,
            pairingCode: '', // Add appropriate pairingCode value here
            isMuted: false,
            isPoweredOn: false,
            volume: 0,
          ),
        );
      } else {
        logBle.warning('Device disconnected before discovering services');
        state = BleDisconnected();
      }
    } catch (e) {
      logSys.warning('Error connecting to device: $e');
      state = BleFailedPairing();
      await _cleanup();
    }
  }

  @override
  Future<void> disconnect() async {
    await _cleanup();
    _setState(BleDisconnected());
  }

  @override
  Stream<List<int>> subscribeToCharacteristic() {
    final current = state;
    if (current is! BlePaired) {
      throw StateError('BLE not ready');
    }

    current.txCharacteristic.setNotifyValue(true);

    return current.txCharacteristic.lastValueStream;
  }

  @override
  Stream<BleState> watchState() => _controller.stream;

  @override
  Future<void> writeData({required List<int> data}) async {
    final current = state;
    if (current is! BlePaired) {
      throw StateError('BLE not ready');
    }

    if (_device == null) {
      throw StateError('Device not connected');
    }

    await current.rxCharacteristic.write(data, withoutResponse: true);
  }

  void dispose() {
    _cleanup();
  }

  Future<void> _cleanup() async {
    await _connectionSub?.cancel();
    _connectionSub = null;
    _isInitialized = false;

    if (_device != null) {
      try {
        await _device!.disconnect();
      } catch (_) {}
      _device = null;
    }
  }

  List<ScanResult> _mergeResults(
    List<ScanResult> current,
    List<ScanResult> incoming,
  ) {
    final map = <DeviceIdentifier, ScanResult>{};

    for (final r in current) {
      map[r.device.remoteId] = r;
    }
    for (final r in incoming) {
      map[r.device.remoteId] = r;
    }

    return map.values.toList()
      ..sort((a, b) => b.rssi.compareTo(a.rssi)); // sort mạnh → yếu
  }

  Future<void> _stopInternal() async {
    await _scanSub?.cancel();
    _scanSub = null;

    try {
      await FlutterBluePlus.stopScan();
    } catch (_) {}
  }

  void _setState(BleState s) {
    var oldState = state;

    if (s is BlePaired && oldState is! BlePaired) {
      // Not paired → paired
      // Start heartbeat
      logHb.info('Starting heartbeat sending timer');
      _heartbeatTimer = Timer.periodic(Duration(seconds: 2), (_) async {
        if (_enableHeartbeat == false) {
          return;
        }

        logHb.info('Sending heartbeat to TV ...');

        try {
          var evt = InputEvent(heartBeat: HeartBeatReqEvent(version: '1.0.0'));
          await writeData(data: evt.writeToBuffer());
        } catch (e) {
          logHb.warning('Send heartbeat failed: $e');
        }
      });

      _heartBeatCheck?.cancel();
      _heartBeatCheck = Timer.periodic(Duration(seconds: 3), (_) {
        if (_enableHeartbeat == false) {
          return;
        }

        logHb.info('Checking if heartbeat still working ...');

        final now = DateTime.now();
        final diff = now.difference(_lastReceivedHeartBeat);
        // logHb.info( 'Diff: ${diff.inSeconds} seconds');

        if (diff.inSeconds > 30 && _heartbeatLevel == 1) {
          logHb.warning(
            'No heartbeat response received in the last ${diff.inSeconds} seconds. Disconnecting BLE.',
          );

          disconnect();

          _heartBeatCheck?.cancel();
          _heartBeatCheck = null;
        } else if (diff.inSeconds > 4 && _heartbeatLevel == 0) {
          logHb.warning(
            'Heartbeat response delayed (> 4 secs). Last received ${diff.inSeconds} seconds ago.',
          );

          var current = state;
          if (current is BlePaired) {
            _setState(current.copyWith(reconnectRemoteId: current.remoteId));
          }

          _heartbeatLevel = 1;
        } else if (diff.inSeconds < 4) {
          logHb.info(
            'Heartbeat is healthy. Last received ${diff.inSeconds} seconds ago.',
          );

          var current = state;
          if (current is BlePaired) {
            _setState(current.copyWith(reconnectRemoteId: null));
          }

          _heartbeatLevel = 0;
        }
      });
    } else if (oldState is BlePaired && s is! BlePaired) {
      // Paired → not paired
      // Stop heartbeat
      _heartbeatTimer?.cancel();
      _heartbeatTimer = null;

      _heartbeatResponseSub?.cancel();
      _heartbeatResponseSub = null;
      _heartbeatResponseStream = null;

      _heartBeatCheck?.cancel();
      _heartBeatCheck = null;
    }

    state = s;
    _controller.add(s);

    if (s is BlePaired && oldState is! BlePaired) {
      // Not paired → paired
      // Check heartbeat response
      _lastReceivedHeartBeat = DateTime.now();
      _heartbeatResponseStream = subscribeToCharacteristic();
      _heartbeatResponseSub = _heartbeatResponseStream?.listen((data) {
        var resp = Response.fromBuffer(data);
        if (resp.hasHeartBeat()) {
          _lastReceivedHeartBeat = DateTime.now();

          logSys.info('Received heartbeat response from TV');

          int volume = resp.heartBeat.volume.toInt();

          var current = state;
          if (current is BlePaired) {
            logSys.info(
              'Received $volume, current: ${current.volume}',
            );

            String? newVersion;
            String? newVersionUrl;

            if (resp.hasUpgradeRequest()) {
              var upgrade = resp.upgradeRequest;
              logSys.info(
                'Received upgrade request: version=${upgrade.newVersion}, url=${upgrade.downloadUrl}',
              );

              if (isNewer(AppInfo.version, upgrade.newVersion)) {
                newVersion = upgrade.newVersion;
                newVersionUrl = upgrade.downloadUrl;
              }
            }

            if (current.isMuted != resp.heartBeat.isMuted ||
                current.isPoweredOn != resp.heartBeat.isPoweredOn || 
                current.volume != volume || newVersion != null) {
              logSys.info('Updating heartbeat state in BlePaired');

              _setState(
                current.copyWith(
                  isPoweredOn: resp.heartBeat.isPoweredOn,
                  isMuted: resp.heartBeat.isMuted,
                  volume: volume,
                  newVersion: newVersion,
                  newVersionUrl: newVersionUrl,
                ),
              );
            }
          }
        }
      });
    }
  }

  bool isNewer(String oldVersion, String newVersion) {
    List<String> oldParts = oldVersion.split('.');
    List<String> newParts = newVersion.split('.');

    for (int i = 0; i < Math.max(oldParts.length, newParts.length); i++) {
      int oldPart = i < oldParts.length ? int.parse(oldParts[i]) : 0;
      int newPart = i < newParts.length ? int.parse(newParts[i]) : 0;

      if (newPart > oldPart) {
        return true;
      } else if (newPart < oldPart) {
        return false;
      }
    }

    return false; // Versions are equal
  }

  @override
  bool isScanning() {
    return _isScanning;
  }

  @override
  void enableHeartbeat({required bool enable}) {
    _enableHeartbeat = enable;

    if (enable) {
      logHb.info('Heartbeat enabled');
    } else {
      logHb.info('Heartbeat disabled');
    }

    _heartbeatLevel = 0;
    _lastReceivedHeartBeat = DateTime.now();
  }

  @override
  void updateDownloadPercent(int percent)
  {
    var current = state;
    if (current is BlePaired) {
      _setState(current.copyWith(downloadPercent: percent));
    }
  }
}
