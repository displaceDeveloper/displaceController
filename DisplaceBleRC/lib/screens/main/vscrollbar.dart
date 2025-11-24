import 'dart:math';

import 'package:displacerc/constants/app_sizes.dart';
import 'package:displacerc/screens/main/mouse_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'scroll_types.dart';

class VScrollBar extends StatefulWidget {
  final bool isLeft;

  final VoidCallback? onScrollStart;
  final VoidCallback? onScrollEnd;
  final ScrollChangeEventListener? onScrollChange;

  const VScrollBar({
    super.key,
    required this.isLeft,
    this.onScrollStart,
    this.onScrollEnd,
    this.onScrollChange,
  });

  @override
  State<VScrollBar> createState() => _VScrollBarState();
}

class _VScrollBarState extends State<VScrollBar> {
  static final double widgetWidth = 30;
  static final double handleHeight = 50;
  static final double handleMargin = (widgetWidth - widgetWidth * 0.7) / 2;
  static final double radius = 10;

  // Const items, initialized once
  double widgetHeight = 0;
  double _baseY = 0;
  bool pressed = false;
  double lastY = 0;

  double _position = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widgetHeight != 0) return;

      widgetHeight = context.size?.height ?? 0;

      setState(() {
        _baseY = (widgetHeight - handleHeight) / 2;
        _position = _baseY;
      });
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: widget.isLeft
            ? BorderRadius.only(
                topRight: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
              ),
      ),
      child: SizedBox(
        width: widgetWidth,
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Gap(AppSizes.gap),
                Icon(Icons.keyboard_double_arrow_up, color: Color(0xFF403A3A)),
                Expanded(child: Container()),
                Icon(
                  Icons.keyboard_double_arrow_down,
                  color: Color(0xFF403A3A),
                ),
                Gap(AppSizes.gap),
              ],
            ),
            Positioned(
              top: _position,
              left: handleMargin,
              child: Container(
                width: widgetWidth * 0.7,
                height: handleHeight,
                decoration: BoxDecoration(
                  color: Color(0xFF201D1D),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            MouseArea(
              onPanStart: _onPanStart,
              onPanEnd: _onPanEnd,
              onPanUpdate: _onPanUpdate,
              child: Container(color: Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails evt) {
    pressed = true;
    lastY = evt.localPosition.dy;

    var startHandler = widget.onScrollStart;

    if (startHandler != null) {
      startHandler();
    }
  }

  void _onPanEnd(DragEndDetails evt) {
    pressed = false;

    setState(() {
      _position = _baseY;
    });

    var handler = widget.onScrollChange;
    var endHandler = widget.onScrollEnd;

    if (handler != null) {
      handler(0);
    }

    if (endHandler != null) {
      endHandler();
    }
  }

  void _onPanUpdate(DragUpdateDetails evt) {
    var dy = evt.localPosition.dy - lastY;

    var newPosition = _baseY + dy;

    setState(() {
      _position = newPosition.clamp(
        handleMargin,
        widgetHeight - handleHeight - handleMargin,
      );
    });

    var handler = widget.onScrollChange;
    if (handler == null) {
      return;
    }

    if (dy < 0) {
      dy = max(dy, -widgetHeight);
    } else if (dy > 0) {
      dy = min(dy, widgetHeight);
    }

    handler(dy);
  }
}
