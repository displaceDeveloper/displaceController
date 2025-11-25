import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:displacerc/components/dp_circle_button.dart';
import 'package:displacerc/components/dp_icon.dart';
import 'package:displacerc/components/dp_page.dart';
import 'package:displacerc/components/dp_power_button.dart';
import 'package:displacerc/components/dp_text_button.dart';
import 'package:displacerc/components/dp_text_button_white.dart';
import 'package:displacerc/constants/app_info.dart';
import 'package:displacerc/constants/app_sizes.dart';
import 'package:displacerc/core/ble/ble_state.dart';
import 'package:displacerc/core/db/app_database.dart';
import 'package:displacerc/core/db/db_provider.dart';
import 'package:displacerc/core/logger.dart';
import 'package:displacerc/core/screen/screen_providers.dart';
import 'package:displacerc/core/screen/screen_state.dart';
import 'package:displacerc/core/timer_util.dart';
import 'package:displacerc/screens/main/hscrollbar.dart';
import 'package:displacerc/screens/main/main_provider.dart';
import 'package:displacerc/screens/main/mouse_area.dart';
import 'package:displacerc/screens/main/vscrollbar.dart';
import 'package:flutter/services.dart';
import 'package:displacerc/core/msg/msg.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:gap/gap.dart';
import 'package:hardware_button_listener/hardware_button_listener.dart';
import 'package:hardware_button_listener/models/hardware_button.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/ble/ble_providers.dart';

class ScreenMain extends ConsumerStatefulWidget {
  const ScreenMain({super.key});

  @override
  ConsumerState<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends ConsumerState<ScreenMain>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final textFocusNode = FocusNode();
  final textFieldFocusNode = FocusNode();
  final TextEditingController _kbController = TextEditingController();

  // Scroll
  late final TimerUtil _timerSendScroll;
  double val = 0;
  bool isVerticalScroll = false;

  bool bottomSheetVisible = false;
  List<BleDevice> devices = [];

  bool justConnected = false;
  bool shouldReconnect = false;

  // Rename
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  final _hardwareButtonListener = HardwareButtonListener();
  final Connectivity _connectivity = Connectivity();

  int? downloadPercent;

  _ScreenMainState() {
    _timerSendScroll = TimerUtil(
      interval: const Duration(milliseconds: 50),
      onTriggered: sendScrollEvent,
      repeat: true,
    );
  }

  void sendScrollEvent() {
    if (val == 0) {
      return;
    }

    final bleController = ref.read(bleControllerProvider.notifier);

    InputEvent evt;
    if (isVerticalScroll) {
      evt = InputEvent(mouseVscroll: MouseVScrollEvent(value: val * 0.7));
    } else {
      evt = InputEvent(mouseHscroll: MouseHScrollEvent(value: val * 0.7));
    }

    bleController.writeData(evt.writeToBuffer());
  }

  @override
  void initState() {
    super.initState();

    _hardwareButtonListener.listen((event) {
      var bleState = ref.read(bleControllerProvider);
      if (bleState is! BlePaired) {
        return;
      }

      if (event.buttonName == "VOLUME_UP") {
        var evt = InputEvent(volumeChange: VolumeChangeEvent(volume: 1));
        ref.read(bleControllerProvider.notifier).writeData(evt.writeToBuffer());
      } else if (event.buttonName == "VOLUME_DOWN") {
        var evt = InputEvent(volumeChange: VolumeChangeEvent(volume: -1));
        ref.read(bleControllerProvider.notifier).writeData(evt.writeToBuffer());
      }
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      ref.read(bleControllerProvider.notifier).enableHeartbeat(enable: false);
    } else if (state == AppLifecycleState.resumed) {
      logSys.info('App resumed from background');

      Future.delayed(Duration(seconds: 1), () {
        logSys.info(
          'type of bleState is ${ref.read(bleControllerProvider).runtimeType}',
        );

        ref.read(bleControllerProvider.notifier).enableHeartbeat(enable: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainState = ref.watch(mainProvider);
    final mainController = ref.read(mainProvider.notifier);

    final bleState = ref.watch(bleControllerProvider);
    final bleController = ref.read(bleControllerProvider.notifier);

    final screenState = ref.watch(screenControllerProvider);
    if (screenState is! ScreenStateMain) {
      throw StateError("Not in main screen state anymore");
    }

    final asyncDevices = ref.watch(bleDevicesStreamProvider);
    asyncDevices.when(
      data: (devs) {
        setState(() {
          devices = devs;
        });

        if (screenState.reconnectDeviceId != null) {
          // Auto reconnect

          if (mainState.isFirstLaunch) {
            // Reconnect to last active device in the first launch
            var lastActiveId = screenState.reconnectDeviceId!;

            var lastActiveDevice = devs.firstWhereOrNull(
              (dev) => dev.id == lastActiveId,
            );

            if (lastActiveDevice != null) {
              logConn.info(
                'Auto-reconnecting to last active device ${lastActiveDevice.name}($lastActiveId)',
              );

              WidgetsBinding.instance.addPostFrameCallback((_) {
                justConnected = true;
                mainController.setActiveDeviceName(lastActiveDevice.name);
                bleController.connect(
                  deviceId: lastActiveId,
                  tvCode: lastActiveDevice.tvCode,
                );
                mainController.clearFirstLaunch();
              });
            }
          }
        }
      },
      loading: () {},
      error: (e, st) {},
    );

    var isConnecting =
        (bleState is BleConnecting) ||
        (bleState is BlePaired && bleState.reconnectRemoteId != null) ||
        (screenState.reconnectDeviceId != null);

    if (isConnecting) {
      bottomSheetVisible = true;
    }

    if (bleState is! BlePaired) {
      if (shouldReconnect) {
        shouldReconnect = false;
        logConn.info('Device disconnected, disabling auto-reconnect');
      }

      if (!bottomSheetVisible) {
        logConn.info('Force showing bottom sheet to pair device');
        Future.microtask(() {
          setState(() {
            bottomSheetVisible = true;
          });
        });
      }
    } else {
      if (!shouldReconnect) {
        shouldReconnect = true;
        logConn.info('Device paired, enable auto-reconnect on disconnect');
      }

      if (justConnected) {
        logConn.info('Paired to device, hiding bottom sheet');
        justConnected = false;

        if (bottomSheetVisible) {
          Future.microtask(() {
            setState(() {
              bottomSheetVisible = false;
            });
          });
        }
      }
    }

    ref.listen(bleControllerProvider, (previous, next) {
      if (next is BlePaired || next is BleFailedPairing) {
        ref.read(screenControllerProvider.notifier).clearReconnectDeviceId();
      }
    });

    var showUpdateDialog =
        bleState is BlePaired && bleState.showUpdateDialog == true;

    return DpPage(
      scaffoldKey: _scaffoldKey,
      body: Stack(
        children: [
          Column(
            children: [
              if (mainState.showAppBar) _appBar(),
              if (!mainState.showAppBar) _keyboardTitle(),

              if (mainState.showKeyboard)
                KeyboardListener(
                  focusNode: textFocusNode,
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.backspace) {
                      logSys.info('Backspace pressed');

                      var evt = InputEvent(
                        keyControl: KeyControlEvent(
                          key: KeyControl.KEY_BACKSPACE,
                        ),
                      );

                      ref
                          .read(bleControllerProvider.notifier)
                          .writeData(evt.writeToBuffer());
                    }
                  },
                  child: TextField(
                    focusNode: textFieldFocusNode,
                    controller: _kbController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: mainState.keyboardInputPlaceholder,
                      hintStyle: TextStyle(color: Color(0xFF918B8B)),
                    ),
                    onEditingComplete: () {
                      logSys.info('Enter pressed');

                      var evt = InputEvent(
                        keyControl: KeyControlEvent(key: KeyControl.KEY_ENTER),
                      );

                      ref
                          .read(bleControllerProvider.notifier)
                          .writeData(evt.writeToBuffer());

                      _kbController.clear();
                      mainController.updateLastString('');
                    },
                    onChanged: (value) {
                      var lastValue = mainState.lastString ?? '';
                      mainController.updateLastString(value);

                      if (value.isEmpty || value.length < lastValue.length) {
                        // Delete action, ignore for now
                        return;
                      }

                      var lastChar = value.characters.last;

                      var evt = InputEvent(
                        keyString: KeyStringEvent(str: lastChar),
                      );

                      ref
                          .read(bleControllerProvider.notifier)
                          .writeData(evt.writeToBuffer());
                    },
                  ),
                ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(child: Container(color: Colors.black)),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 390,
                            minHeight: 150,
                          ),
                          child: _trackpad(),
                        ),
                        if (mainState.showKeyboard)
                          SizedBox(
                            height: 15,
                            child: Container(color: Colors.black),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          IgnorePointer(
            ignoring: !bottomSheetVisible,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              offset: bottomSheetVisible ? Offset.zero : const Offset(0, 1),
              child: _bottomSheet(),
            ),
          ),
          IgnorePointer(
            ignoring: !mainState.showRename,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              offset: mainState.showRename ? Offset.zero : const Offset(0, 1),
              child: _renameTv(),
            ),
          ),
          IgnorePointer(
            ignoring: !showUpdateDialog,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              offset: showUpdateDialog ? Offset.zero : const Offset(0, 1),
              child: _newVersion(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _trackpad() {
    var mainState = ref.watch(mainProvider);
    var mainController = ref.read(mainProvider.notifier);
    final keyboardColor = mainState.showKeyboard ? Colors.blue : Colors.white;

    return Stack(
      children: [
        MouseArea(
          onTap: () {
            var evt = InputEvent(
              mouseClick: MouseClickEvent(
                button: MouseButton.MOUSE_BUTTON_LEFT,
              ),
            );

            ref
                .read(bleControllerProvider.notifier)
                .writeData(evt.writeToBuffer());
          },
          onPanUpdate: (event) {
            var evt = InputEvent(
              mouseMove: MouseMoveEvent(
                dx: (event.delta.dx * 2.5).toInt(),
                dy: (event.delta.dy * 2.5).toInt(),
              ),
            );

            ref
                .read(bleControllerProvider.notifier)
                .writeData(evt.writeToBuffer());
          },
          child: Container(
            color: Color(0xFF201D1D),
            child: Center(
              child: Text(
                "Trackpad",
                style: TextStyle(color: Color(0xFFB2ABAB)),
              ),
            ),
          ),
        ),

        // Top row
        Positioned(left: 0, right: 0, top: AppSizes.gap, child: _topRow()),

        // Left scrollbar
        Positioned(
          top: 110,
          bottom: 20,
          left: 0,
          child: VScrollBar(
            isLeft: true,
            onScrollStart: _onVScrollStart,
            onScrollEnd: _onVScrollEnd,
            onScrollChange: _onVScroll,
          ),
        ),

        // Right scrollbar
        Positioned(
          top: 110,
          bottom: 20,
          right: 0,
          child: VScrollBar(
            isLeft: false,
            onScrollStart: _onVScrollStart,
            onScrollEnd: _onVScrollEnd,
            onScrollChange: _onVScroll,
          ),
        ),

        // Bottom scrollbar
        Positioned(
          right: 60,
          left: 60,
          bottom: 0,
          child: HScrollBar(
            onScrollStart: _onHScrollStart,
            onScrollEnd: _onHScrollEnd,
            onScrollChange: _onHScroll,
          ),
        ),

        //
        Positioned(
          right: 60,
          left: 60,
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (mainState.showKeyboard) {
                    mainController.hideKeyboard();
                  } else {
                    mainController.showKeyboard(
                      keyboardInputPlaceholder: "start typing ...",
                      showSearch: false,
                    );
                    textFieldFocusNode.requestFocus();
                  }
                },
                child: Column(
                  children: [
                    Icon(Icons.keyboard, color: keyboardColor, size: 24),
                    Text(
                      'keyboard',
                      style: TextStyle(
                        color: keyboardColor,
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Icon(Icons.mic, color: Colors.white, size: 24),
                    Text(
                      'voice',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onVScrollStart() {
    val = 0;
    isVerticalScroll = true;

    _timerSendScroll.start();
  }

  void _onVScrollEnd() {
    _timerSendScroll.stop();
  }

  void _onVScroll(double val) {
    this.val = val;
    isVerticalScroll = true;
  }

  void _onHScrollStart() {
    val = 0;
    isVerticalScroll = false;

    _timerSendScroll.start();
  }

  void _onHScrollEnd() {
    _timerSendScroll.stop();
  }

  void _onHScroll(double val) {
    this.val = val;
    isVerticalScroll = false;
  }

  Widget _topRow() {
    final mainController = ref.read(mainProvider.notifier);
    final mainState = ref.watch(mainProvider);
    final bleState = ref.watch(bleControllerProvider);
    final bleController = ref.read(bleControllerProvider.notifier);
    bool isMuted = (bleState is BlePaired) ? bleState.isMuted : false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DpCircleButton(
          onPressed: () {
            var evt = InputEvent(
              controlButton: ControlEvent(type: ControlType.TYPE_SEARCH),
            );
            bleController.writeData(evt.writeToBuffer());

            mainController.showKeyboard(
              keyboardInputPlaceholder: "search anything ...",
              showSearch: true,
            );
            textFieldFocusNode.requestFocus();
          },
          child: DpIcon(
            icon: Icons.search,
            color: mainState.showSearch ? Colors.blue : Colors.white,
          ),
        ),
        Container(
          width: 230,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DpCircleButton(
                onPressed: () {
                  var evt = InputEvent(
                    controlButton: ControlEvent(type: ControlType.TYPE_BACK),
                  );
                  bleController.writeData(evt.writeToBuffer());
                },
                backgroundColor: Colors.transparent,
                child: DpIcon(icon: Icons.arrow_back),
              ),
              DpCircleButton(
                onPressed: () {
                  var evt = InputEvent(
                    controlButton: ControlEvent(type: ControlType.TYPE_HOME),
                  );
                  bleController.writeData(evt.writeToBuffer());
                },
                backgroundColor: Colors.transparent,
                child: DpIcon(icon: Icons.home),
              ),
              DpCircleButton(
                onPressed: () {
                  var evt = InputEvent(
                    controlButton: ControlEvent(
                      type: ControlType.TYPE_PLAY_PAUSE,
                    ),
                  );
                  bleController.writeData(evt.writeToBuffer());
                },
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(0),
                child: DpIcon(icon: Symbols.play_pause, size: 45),
              ),
            ],
          ),
        ),
        DpCircleButton(
          onPressed: () {
            bleController.toggleMute();

            var evt = InputEvent(
              controlButton: ControlEvent(
                type: ControlType.TYPE_MUTE_UNMUTE,
                value: isMuted ? 0 : 1,
              ),
            );
            bleController.writeData(evt.writeToBuffer());
          },
          child: DpIcon(icon: isMuted ? Icons.volume_off : Icons.volume_up),
        ),
      ],
    );
  }

  Widget _keyboardTitle() {
    var mainState = ref.watch(mainProvider);
    var mainController = ref.read(mainProvider.notifier);

    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.tv),
              Gap(AppSizes.gap),
              Text(mainState.activeDeviceName ?? "No Name"),
            ],
          ),
          Positioned(
            right: 20,
            child: GestureDetector(
              onTap: () {
                _kbController.clear();
                mainController.updateLastString('');

                mainController.hideKeyboard();
              },
              child: Text(
                "DONE",
                style: TextStyle(
                  color: Color(0xFF269AE2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    final bleController = ref.read(bleControllerProvider.notifier);

    final mainState = ref.watch(mainProvider);

    return Container(
      color: Color(0xFF201D1D),
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              setState(() {
                bottomSheetVisible = true;
              });
            },
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.tv),
                Gap(AppSizes.gap),
                Text(
                  mainState.activeDeviceName ?? "No Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          DpPowerButton(
            onTurnOn: () {
              bleController.turnOnTv();

              var evt = InputEvent(
                controlButton: ControlEvent(type: ControlType.TYPE_POWER_ON),
              );
              bleController.writeData(evt.writeToBuffer());
            },
            onTurnOff: () {
              bleController.turnOffTv();

              var evt = InputEvent(
                controlButton: ControlEvent(type: ControlType.TYPE_POWER_OFF),
              );
              bleController.writeData(evt.writeToBuffer());
            },
          ),
        ],
      ),
    );
  }

  Widget _tile({
    bool isActive = false,
    required String name,
    required String id,
    required String tvCode,
  }) {
    var db = ref.read(dbProvider);
    var bleState = ref.read(bleControllerProvider);
    var mainState = ref.read(mainProvider);
    var screenState = ref.read(screenControllerProvider);

    var isConnecting =
        (isActive && mainState.isFirstLaunch) ||
        (bleState is BleConnecting && bleState.remoteId == id) ||
        (bleState is BlePaired && bleState.reconnectRemoteId == id) ||
        (screenState is ScreenStateMain && screenState.reconnectDeviceId == id);

    if (isConnecting) {
      logConn.info('Device $name($id) is connecting');
      isActive = false;
    }

    if (!isActive && bleState is BleDisconnected) {
      isActive = false;
    }

    var mainController = ref.read(mainProvider.notifier);
    var screenController = ref.read(screenControllerProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: isActive ? Color(0xFF42B8FD) : Color(0xFF808080),
        ),
        color: isActive ? Colors.black : Colors.transparent,
      ),
      child: SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.tv,
              size: 30,
              color: isActive ? Color(0xFF42B8FD) : Colors.white,
            ),
            Gap(AppSizes.gap),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: isActive ? Color(0xFF42B8FD) : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _nameController.text = name;
                      mainController.showRenameTv(id);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Symbols.edit_square,
                          size: 13,
                          fontWeight: FontWeight.w300,
                        ),
                        Gap(5),
                        Text(
                          "Rename",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isActive)
              _btn(
                text: "UNPAIR",
                icon: Icon(Icons.tv, color: Colors.white),
                showClose: true,
                onPressed: () {
                  logSys.info('Unpairing device $name($id)');
                  shouldReconnect = false;

                  var bleController = ref.read(bleControllerProvider.notifier);
                  bleController.disconnect();
                  db.deactivateAllBleDevices();
                },
              )
            else
              Row(
                children: [
                  if (!isConnecting)
                    _btn(
                      text: "REMOVE",
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () async {
                        await db.deleteBleDevice(id);
                        if (!await db.hasAnyBleDevice()) {
                          screenController.gotoScan(cancelable: false);
                        }
                      },
                    ),

                  if (isConnecting)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  else
                    _btn(
                      text: "PAIR",
                      icon: Icon(Icons.tv, color: Colors.white),
                      onPressed: () {
                        var bleState = ref.read(bleControllerProvider);
                        var bleController = ref.read(
                          bleControllerProvider.notifier,
                        );

                        if (bleState is BleConnected || bleState is BlePaired) {
                          logSys.info(
                            'Already connected to another device, disconnecting first',
                          );
                          bleController.disconnect();
                        }

                        var screenController = ref.read(
                          screenControllerProvider.notifier,
                        );

                        screenController.clearReconnectDeviceId();
                        justConnected = true;
                        bleController.connect(deviceId: id, tvCode: tvCode);
                        mainController.setActiveDeviceName(name);

                        db.deactivateAllBleDevices();
                        db.updateBleDevice(id, isActive: true);
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _btn({
    bool showClose = false,
    VoidCallback? onPressed,
    required String text,
    required Icon icon,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showClose)
            Stack(
              children: [
                icon,
                Positioned(
                  top: 2,
                  left: 3.5,
                  child: Icon(Icons.close, color: Colors.white, size: 12),
                ),
              ],
            )
          else
            icon,
          Gap(4),
          Text(text, style: TextStyle(fontSize: 10, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _newVersion() {
    var bleState = ref.watch(bleControllerProvider);
    if (bleState is! BlePaired) {
      return Container();
    }

    var newVersion = bleState.newVersion ?? "";

    return Container(
      color: Colors.black.withAlpha(210),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Version $newVersion",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(AppSizes.gap * 2),

                if (downloadPercent == null) ...[
                  Text(
                    (bleState.forceUpdate != true)
                        ? "A new controller version\nis available."
                        : "A new controller version is available.\nUpdate Required.",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  Gap(AppSizes.gap * 2),
                  DpTextButton(
                    onPressed: () async {
                      try {
                        var current = bleState;

                        var result = await _connectivity.checkConnectivity();
                        var wifiResult = result.singleWhereOrNull(
                          (c) => c == ConnectivityResult.wifi,
                        );
                        if (wifiResult == null) {
                          logConn.info(
                            'Not connected to WiFi, cannot proceed to download',
                          );
                          AppSettings.openAppSettings(
                            type: AppSettingsType.wifi,
                          );
                          return;
                        }

                        setState(() {
                          downloadPercent = 0;
                        });

                        // Upgrade
                        ref
                            .read(bleControllerProvider.notifier)
                            .downloadAndInstall(
                              current.newVersionUrl!,
                              onProgress: (received, total) {
                                var percent = (received / total * 100).toInt();

                                setState(() {
                                  downloadPercent = percent == 100
                                      ? null
                                      : percent;
                                });
                              },
                            );
                      } catch (e) {
                        logConn.info('Failed to check connectivity: $e');
                        return;
                      }
                    },
                    child: Text("Update"),
                  ),
                  if (bleState.forceUpdate != true) ...[
                    Gap(AppSizes.gap),
                    DpTextButtonWhite(
                      onPressed: () {
                        setState(() {
                          downloadPercent = null;
                        });
                        
                        ref
                            .read(bleControllerProvider.notifier)
                            .showUpdateDialog(false);
                      },
                      borderColor: Colors.black,
                      child: Text("Not Now"),
                    ),
                  ],
                ] else ...[
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    padding: EdgeInsets.all(10),
                  ),
                  Gap(AppSizes.gap * 2),

                  Text("Downloading Update", style: TextStyle(color: Colors.black),),
                  Text("$downloadPercent%", style: TextStyle(color: Colors.black),),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renameTv() {
    final mainState = ref.watch(mainProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mainState.showRename) {
        return;
      }

      _nameFocusNode.requestFocus();
    });

    return Container(
      color: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFF201D1D),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.tv),
                  Gap(AppSizes.gap),
                  Text("Rename TV"),
                ],
              ),
              Gap(AppSizes.gap),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(
                          0xFFB2ABAB,
                        ).withAlpha((255 * 65 / 100).round()),
                      ),
                    ),
                    hintText: 'Enter a name for this TV',
                    hintStyle: TextStyle(
                      color: Color(
                        0xffB2ABAB,
                      ).withAlpha((255 * 65 / 100).round()),
                    ),
                  ),
                  onChanged: (_) {},
                ),
              ),
              Gap(AppSizes.gap * 6),
              DpTextButtonWhite(
                onPressed: () {
                  var db = ref.read(dbProvider);
                  db.updateBleDevice(
                    mainState.renameTvId!,
                    name: _nameController.text.trim(),
                  );
                  _nameFocusNode.unfocus();
                  ref.read(mainProvider.notifier).hideRenameTv();
                },
                child: Text("Done"),
              ),
              Gap(AppSizes.gap * 2),
              DpTextButton(
                onPressed: () {
                  _nameFocusNode.unfocus();
                  ref.read(mainProvider.notifier).hideRenameTv();
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    final bleState = ref.watch(bleControllerProvider);
    bool hasConnection = bleState is BlePaired;
    String connectedRemoteId = "";
    if (bleState is BlePaired) {
      connectedRemoteId = bleState.remoteId;
    }

    var activeDevice = devices.firstWhereOrNull(
      (dev) => dev.id == connectedRemoteId,
    );
    var inactiveDevices = devices
        .where((dev) => dev.id != connectedRemoteId)
        .toList();

    return Container(
      color: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFF201D1D),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "My TVs",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                if (hasConnection)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          bottomSheetVisible = false;
                        });
                      },
                    ),
                  ),
              ],
            ),
            Gap(AppSizes.scanGap),
            SizedBox(width: 130, child: _btnPairNewTv()),
            Gap(AppSizes.scanGap),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 0,
                ),
                child: ListView(
                  children: [
                    if (activeDevice != null)
                      _tile(
                        id: activeDevice.id,
                        name: activeDevice.name,
                        isActive: true,
                        tvCode: activeDevice.tvCode,
                      ),
                    Gap(AppSizes.gap),
                    ...inactiveDevices.expand(
                      (e) => [
                        Gap(AppSizes.gap),
                        _tile(id: e.id, name: e.name, tvCode: e.tvCode),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (activeDevice == null) Gap(AppSizes.gap),
            if (activeDevice == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.touch_app,
                    color: Color(0xFFB2ABAB).withAlpha(150),
                  ),
                  Gap(AppSizes.gap),
                  Text(
                    "Pair this controller\nwith a Displace TV",
                    style: TextStyle(color: Color(0xFFB2ABAB).withAlpha(150)),
                  ),
                ],
              ),
            Gap(AppSizes.gap * 3),
            if (downloadPercent == null &&
                bleState is BlePaired &&
                bleState.newVersion != null)
              DpTextButtonWhite(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Version ${bleState.newVersion!}",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Update Now",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  ref
                      .read(bleControllerProvider.notifier)
                      .showUpdateDialog(true);
                },
              ),

            // if (downloadPercent != null)
            //  Text("Downloading update: $downloadPercent%"),
            Gap(AppSizes.gap),
            Text(
              "Version ${AppInfo.version}",
              style: TextStyle(color: Color(0xFFB2ABAB).withAlpha(150)),
            ),
            Gap(AppSizes.gap),
          ],
        ),
      ),
    );
  }

  Widget _btnPairNewTv() {
    var screenController = ref.read(screenControllerProvider.notifier);

    return FilledButton(
      onPressed: () {
        screenController.gotoScan(cancelable: true);
      },
      style: FilledButton.styleFrom(
        backgroundColor: Color(0xFF05649F),
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: Color(0xFF808080)),
      ),
      child: Row(
        children: [
          Icon(Icons.add, color: Colors.white),
          Gap(5),
          Expanded(
            child: Text(
              "Pair New TV",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
