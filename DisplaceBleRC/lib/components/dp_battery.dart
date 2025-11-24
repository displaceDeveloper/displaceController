import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:displacerc/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DpBattery extends StatefulWidget {
  const DpBattery({super.key});

  @override
  State<DpBattery> createState() => _DpBatteryState();
}

class _DpBatteryState extends State<DpBattery> {
  late Battery _battery;

  int _batteryLevel = 0;
  bool _isCharging = false;

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _battery = Battery();

    _timer = Timer.periodic(Duration(seconds: 5), (tmr) async {
      await _updateBatteryLevel();
    });

    _updateBatteryLevel().then((_) {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _updateBatteryLevel() async {
    if (!mounted) return;

    bool charging = (await _battery.batteryState) == BatteryState.charging;
    int level = await _battery.batteryLevel;

    setState(() {
      _batteryLevel = level;
      _isCharging = charging;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$_batteryLevel%"),
        Gap(AppSizes.gap),
        SizedBox(
          width: 30,
          height: 14,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFD9D9D9), width: 2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _batteryLevel / 100.0,
                    child: Container(color: Color(0xFFD9D9D9)),
                  ),
                ),
              ),
              Container(
                width: 3,
                height: 9,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(1),
                    bottomRight: Radius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isCharging) Icon(Icons.bolt, size: 15, color: Color(0xFFD9D9D9)),
      ],
    );
  }
}
