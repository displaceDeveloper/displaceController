import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
sealed class MainState with _$MainState {
  const factory MainState.idle({
    required bool showStatusBar,
    required bool showAppBar,
    required bool isFirstLaunch,
    required bool showSearch,
    required bool showKeyboard,
    required String keyboardInputPlaceholder,
    String? lastString,
    String? activeDeviceName,
    required bool showRename,
    String? renameTvId,

    // Connection info
    String? tvCode,
    String? pairingCode,
  }) = MainIdle;
}