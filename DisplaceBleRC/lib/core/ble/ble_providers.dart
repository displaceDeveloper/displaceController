import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ble_controller.dart';
import 'ble_state.dart';

final bleControllerProvider =
    NotifierProvider<BleController, BleState>(() {
  return BleController();
});

final appBootstrapProvider = Provider<void>((ref) {
  Future.microtask(() {
    ref.read(bleControllerProvider.notifier).startScan(
      timeout: const Duration(seconds: 30),
    );
  });
});