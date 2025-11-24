import 'package:displacerc/components/dp_battery.dart';
import 'package:displacerc/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class DpStatusBar extends StatelessWidget {
  const DpStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: AppSizes.gap,
        left: AppSizes.gap * 2,
        right: AppSizes.gap * 2,
        bottom: AppSizes.gap * 2,
      ),
      color: Colors.black,
      child: Row(
      children: [
        Image.asset("assets/images/logo.png", height: 10,),
        Expanded(child: Container()),
        DpBattery()
      ],
    ),);
  }
}
