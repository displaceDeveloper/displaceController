import 'package:displacerc/core/ble/ble_providers.dart';
import 'package:displacerc/core/ble/ble_state.dart';
import 'package:displacerc/screens/main/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DpPowerButton extends ConsumerStatefulWidget {
  final VoidCallback onTurnOn;
  final VoidCallback onTurnOff;

  const DpPowerButton({
    super.key,
    required this.onTurnOn,
    required this.onTurnOff,
  });

  @override
  ConsumerState<DpPowerButton> createState() => _DpPowerButtonState();
}

class _DpPowerButtonState extends ConsumerState<DpPowerButton> {
  static const double bkWidth = 80;
  static const double bkHeight = 40;

  static const double radius = 10;
  static const double fontSize = 9;

  static const double minX = 0;
  static const double maxX = bkWidth - bkHeight;

  double _position = maxX;
  bool _isOn = true;

  @override
  Widget build(BuildContext context) {
    var mainState = ref.watch(mainProvider);
    bool loading =
        mainState.isTurningOn == true || mainState.isTurningOff == true;

    var bleState = ref.watch(bleControllerProvider);
    var current = bleState;
    if (loading == false) {
      if (current is BlePaired) {
        if (current.isPoweredOn && !_isOn) {
          _position = maxX;
          _isOn = true;
        } else if (!current.isPoweredOn && _isOn) {
          _position = minX;
          _isOn = false;
        }
      }
    }

    return SizedBox(
      width: 80,
      child: Container(
        height: bkHeight,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.black,
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: !_isOn
                        ? Container()
                        : (loading
                              ? _loadingIndicator()
                              : Text(
                                  "TV\nOFF",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: _isOn
                        ? Container()
                        : (loading
                              ? _loadingIndicator()
                              : Text(
                                  "TV\nON",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: () { buttonTapHandler(loading); },
                child: Container(color: Colors.transparent),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              left: _position,
              child: GestureDetector(
                onTap: () { buttonTapHandler(loading); },
                onHorizontalDragUpdate: (details) {
                  if (loading) {
                    return;
                  }

                  var newPosition = _position + details.delta.dx;

                  setState(() {
                    _position = newPosition.clamp(minX, maxX);
                  });
                },
                onHorizontalDragEnd: (_) {
                  if (loading) {
                    return;
                  }

                  if (_isOn) {
                    // Currently on
                    if (_position < maxX * 0.1) {
                      widget.onTurnOff();

                      setState(() {
                        _position = minX;
                        _isOn = false;
                      });
                    } else {
                      setState(() {
                        _position = maxX;
                      });
                    }
                  } else {
                    // Currently off
                    if (_position > maxX * 0.9) {
                      widget.onTurnOn();

                      setState(() {
                        _position = maxX;
                        _isOn = true;
                      });
                    } else {
                      setState(() {
                        _position = minX;
                      });
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: () {
                      if (_isOn) {
                        if (loading) {
                          return Color(
                            0xFF05649F,
                          ).withAlpha((30 * 255 / 100).toInt());
                        }

                        return Color(0xFF05649F);
                      }

                      if (loading) {
                        return Color(
                          0xFFEE123C,
                        ).withAlpha((30 * 255 / 100).toInt());
                      }

                      return Color(0xFFEE123C);
                    }(),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.power_settings_new, size: bkHeight - 8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonTapHandler(bool loading) {
    if (loading) {
      return;
    }

    if (_isOn) {
      widget.onTurnOff();

      setState(() {
        _position = minX;
        _isOn = false;
      });
    } else {
      widget.onTurnOn();

      setState(() {
        _position = maxX;
        _isOn = true;
      });
    }
  }

  Widget _loadingIndicator() {
    return CircularProgressIndicator(
      strokeWidth: 2,
      padding: EdgeInsets.all(10),
    );
  }
}
