import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'ble_state.freezed.dart';

@freezed
sealed class BleState with _$BleState {
  const factory BleState.initialized() = BleInitialized;

  const factory BleState.connecting({String? remoteId}) = BleConnecting;

  const factory BleState.connected({required String remoteId}) = BleConnected;

  const factory BleState.paired({
    required String remoteId,
    required String tvCode,
    required String pairingCode,
    required BluetoothCharacteristic rxCharacteristic,
    required BluetoothCharacteristic txCharacteristic,

    // Heartbeat data
    required bool isTurningOn,
    required bool isTurningOff,
    required bool isPoweredOn,
    required bool isMuted,
    // bool? nextMutedState,
    // required double volume,

    // Id of the device we are reconnecting to
    String? reconnectRemoteId,

    // Upgrade
    bool? showUpdateDialog,
    // int? downloadPercent,
    String? newVersion,
    String? newVersionUrl,
    bool? forceUpdate,
    DateTime? lastUpdateNotified,
  }) = BlePaired;

  const factory BleState.failedPairing() = BleFailedPairing;

  const factory BleState.disconnected() = BleDisconnected;
}
