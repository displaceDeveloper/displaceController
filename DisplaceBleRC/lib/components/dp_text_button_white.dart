import 'package:flutter/material.dart';

class DpTextButtonWhite extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  const DpTextButtonWhite({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: onPressed != null
            ? Colors.white
            : Colors.grey.shade700,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        side: BorderSide(
          color: onPressed != null ? Colors.white : Colors.grey.shade700,
        ),
        padding: EdgeInsets.zero,
        minimumSize: Size(120, 45),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ).merge(style),
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
