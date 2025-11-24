import 'package:displacerc/screens/main/main_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainController extends Notifier<MainState> {
  @override
  MainState build() {
    return MainState.idle(
      showAppBar: true,
      showStatusBar: true,
      isFirstLaunch: true,
      showSearch: false,
      showKeyboard: false,
      keyboardInputPlaceholder: 'start typing ...',
      isTurningOff: false,
      isTurningOn: false,
      showRename: false,
    );
  }

  void updateLastString(String newString) {
    state = state.copyWith(lastString: newString);
  }

  void clearFirstLaunch() {
    if (!state.isFirstLaunch) return;

    state = state.copyWith(isFirstLaunch: false);
  }

  void showKeyboard({
    required String keyboardInputPlaceholder,
    required bool showSearch,
  }) {
    if (state.showKeyboard) return;

    state = state.copyWith(
      showSearch: showSearch,
      showKeyboard: true,
      showStatusBar: false,
      showAppBar: false,
      keyboardInputPlaceholder: keyboardInputPlaceholder,
    );
  }

  void hideKeyboard() {
    state = state.copyWith(
      showSearch: false,
      showKeyboard: false,
      showStatusBar: true,
      showAppBar: true,
    );
  }

  void turnOnTv() {
    state = state.copyWith(isTurningOn: true);

    Future.delayed(const Duration(seconds: 7), () {
      state = state.copyWith(isTurningOn: false);
    });
  }

  void turnOffTv() {
    state = state.copyWith(isTurningOff: true);

    Future.delayed(const Duration(seconds: 7), () {
      state = state.copyWith(isTurningOff: false);
    });
  }

  void setActiveDeviceName(String deviceName) {
    state = state.copyWith(activeDeviceName: deviceName);
  }

  void showRenameTv(String id) {
    state = state.copyWith(showRename: true, renameTvId: id);
  }

  void hideRenameTv() {
    state = state.copyWith(showRename: false, renameTvId: null);
  }

  /* void toggleMute() {
    state = state.copyWith(isMuted: !state.isMuted);
  } */
}
