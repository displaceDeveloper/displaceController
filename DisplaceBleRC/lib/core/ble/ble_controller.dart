import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:displacerc/core/ble/ble_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'ble_state.dart';
import 'ble_service.dart';

class BleController extends Notifier<BleState> {
  late final BleService _service;

  @override
  BleState build() {
    _service = ref.watch(bleServiceProvider);

    _service.watchState().listen((s) {
      state = s;
    });

    return BleInitialized();
  }

  bool isProduction() {
    return _service.isProduction();
  }

  Future<void> startScan({Duration? timeout}) async {
    await _service.startScan(timeout: timeout);
  }

  bool isScanning() {
    return _service.isScanning();
  }

  Future<void> connect({String? deviceId, required String tvCode}) async {
    await _service.connect(deviceId: deviceId, tvCode: tvCode);
  }

  Future<void> writeData(List<int> data) async {
    await _service.writeData(data: data);
  }

  Future<void> disconnect() async {
    await _service.disconnect();
  }

  Stream<List<int>> subscribeToCharacteristic() {
    return _service.subscribeToCharacteristic();
  }

  void enableHeartbeat({required bool enable}) {
    _service.enableHeartbeat(enable: enable);
  }

  void toggleMute() {
    var current = state;
    if (current is! BlePaired) {
      return;
    }

    var muted = current.isMuted;
    state = current.copyWith(isMuted: !muted);
  }

  Future<void> downloadAndInstall(String url, {Function(int, int)? onProgress}) async {
    try {
      // 1. Determine where to save the file
      // Use TemporaryDirectory so the file auto-deletes later, saving storage
      final Directory tempDir = await getTemporaryDirectory();
      final String savePath = '${tempDir.path}/update_app.apk';

      print("Starting download...");

      // 2. Download file using Dio
      final dio = Dio();
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            if (onProgress != null) {
              onProgress(received, total);
            }
          }
        },
      );

      final result = await OpenFile.open(savePath);
      print("File open result: ${result.message}");
    } catch (e) {
      print("Error: $e");
    }
  }
}
