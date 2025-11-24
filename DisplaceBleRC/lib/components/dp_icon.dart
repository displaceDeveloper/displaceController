import 'package:flutter/material.dart';

class DpIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const DpIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 30,
      color: color ?? Colors.white,
    );
  }
}
