import 'dart:async';
import './ble_state.dart';

abstract class BleService {
  bool isProduction();

  Stream<BleState> watchState();

  Future<void> startScan({Duration? timeout});

  Future<void> stopScan();

  bool isScanning();

  void clearDevices();

  Future<void> connect({String? deviceId, required String tvCode});

  Future<void> writeData({required List<int> data});

  Stream<List<int>> subscribeToCharacteristic();

  Future<void> disconnect();

  void enableHeartbeat({required bool enable});

  void updateDownloadPercent(int percent);
}
