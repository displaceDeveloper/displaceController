import 'package:flutter/material.dart';

class DpCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? elevation;

  const DpCircleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        shape: const CircleBorder(),
        padding: padding ?? const EdgeInsets.all(7),
        backgroundColor: backgroundColor ?? Colors.black,
        elevation: elevation,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
