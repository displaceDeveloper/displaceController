import 'package:freezed_annotation/freezed_annotation.dart';

part 'screen_state.freezed.dart';

@freezed
sealed class ScreenState with _$ScreenState {
  const factory ScreenState.permissions() = ScreenStatePermissions;
  const factory ScreenState.scanQr({
    required bool cancelable,
  }) = ScreenStateScanQr;
  const factory ScreenState.pairing({
    required bool cancelable,
  }) = ScreenStatePairing;
  const factory ScreenState.pairError({
    required bool cancelable,
  }) = ScreenStatePairError;
  const factory ScreenState.successfullyPaired() =
      ScreenStateSuccessfullyPaired;
  const factory ScreenState.main({
    String? reconnectDeviceId,
  }) = ScreenStateMain;
}
