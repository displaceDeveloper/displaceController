import 'package:displacerc/core/screen/screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenController extends Notifier<ScreenState> {
  @override
  ScreenState build() {
    return ScreenState.permissions();
  }

  void gotoScan({required bool cancelable}) {
    state = ScreenState.scanQr(cancelable: cancelable);
  }

  void gotoPairing({required bool cancelable}) {
    state = ScreenState.pairing(cancelable: cancelable);
  }

  void gotoPairError({required bool cancelable}) {
    state = ScreenState.pairError(cancelable: cancelable);
  }

  void gotoSuccessfullyPaired() {
    state = ScreenState.successfullyPaired();
  }

  void gotoMain({String? reconnectDeviceId}) {
    state = ScreenStateMain(reconnectDeviceId: reconnectDeviceId);
  }

  void clearReconnectDeviceId() {
    state = ScreenStateMain(reconnectDeviceId: null);
  }
}
