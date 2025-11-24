import 'dart:math';

import 'package:displacerc/constants/app_sizes.dart';
import 'package:displacerc/screens/main/mouse_area.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'scroll_types.dart';

class HScrollBar extends StatefulWidget {
  final VoidCallback? onScrollStart;
  final VoidCallback? onScrollEnd;
  final ScrollChangeEventListener? onScrollChange;

  const HScrollBar({super.key, this.onScrollStart, this.onScrollEnd, this.onScrollChange});

  @override
  State<HScrollBar> createState() => _HScrollBarState();
}

class _HScrollBarState extends State<HScrollBar> {
  static final double widgetHeight = 30;
  static final double handleWidth = 50;
  static final double handleMargin = (widgetHeight - widgetHeight * 0.7) / 2;
  static final double radius = 10;

  // Const items, initialized once
  double widgetWidth = 0;
  double _baseX = 0;
  bool pressed = false;
  double lastX = 0;

  double _position = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widgetWidth != 0) return;

      widgetWidth = context.size?.width ?? 0;

      setState(() {
        _baseX = (widgetWidth - handleWidth) / 2;
        _position = _baseX;
      });
    });

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: widgetHeight,
        child: Stack(
          children: [
            Row(
              children: [
                Gap(AppSizes.gap),
                Icon(
                  Icons.keyboard_double_arrow_left,
                  color: Color(0xFF403A3A),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.keyboard_double_arrow_right,
                  color: Color(0xFF403A3A),
                ),
                Gap(AppSizes.gap),
              ],
            ),
            Positioned(
              left: _position,
              top: handleMargin,
              child: Container(
                width: handleWidth,
                height: widgetHeight * 0.7,
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
    lastX = evt.localPosition.dx;

    if (widget.onScrollStart != null) {
      widget.onScrollStart!();
    }
  }

  void _onPanEnd(DragEndDetails evt) {
    pressed = false;

    setState(() {
      _position = _baseX;
    });

    var handler = widget.onScrollChange;

    if (handler == null) {
      return;
    }

    handler(0);

    if (widget.onScrollEnd != null) {
      widget.onScrollEnd!();
    }
  }

  void _onPanUpdate(DragUpdateDetails evt) {
    var dx = evt.localPosition.dx - lastX;

    var newPosition = _baseX + dx;

    setState(() {
      _position = newPosition.clamp(
        handleMargin,
        widgetWidth - handleWidth - handleMargin,
      );
    });

    var handler = widget.onScrollChange;
    if (handler == null) {
      return;
    }

    if (dx < 0) {
      dx = max(dx, -widgetWidth);
    } else if (dx > 0) {
      dx = min(dx, widgetWidth);
    }

    handler(dx);
  }
}
