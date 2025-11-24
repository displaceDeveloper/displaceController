import 'package:displacerc/core/logger.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class DpBrightness extends StatefulWidget {
  const DpBrightness({super.key});

  @override
  State<DpBrightness> createState() => _DpBrightnessState();
}

class _DpBrightnessState extends State<DpBrightness> {
  double _brightness = 0;

  @override
  void initState() {
    super.initState();
    readBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _brightness,
      min: 0,
      max: 100,
      onChanged: (v) {
        setState(() {
          _brightness = v;
          ScreenBrightness.instance.setApplicationScreenBrightness(v / 100);
        });
      },
    );
  }

  void readBrightness() async {
    double systemBrightness = await ScreenBrightness.instance.system;
    logSys.info("brightness: $systemBrightness");

    setState(() {
      _brightness = systemBrightness * 100;
    });
  }
}
