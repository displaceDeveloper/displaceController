import 'package:flutter/material.dart';

class MouseArea extends StatefulWidget {
  final GestureTapCallback? onTap;
  final GestureDragStartCallback? onPanStart;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final Widget? child;

  const MouseArea({
    super.key,
    this.onTap,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.child,
  });

  @override
  State<MouseArea> createState() => _MouseAreaState();
}

class _MouseAreaState extends State<MouseArea> {
  double remainX = 0;
  double remainY = 0;

  @override
  Widget build(BuildContext context) {
    const double factor = 2.0;

    return GestureDetector(
      onTap: widget.onTap,
      onPanStart: widget.onPanStart,
      onPanEnd: widget.onPanEnd,
      onPanUpdate: (event) {
        double dx = event.delta.dx * factor;
        double dy = event.delta.dy * factor;

        dx += remainX;
        dy += remainY;

        int idx = dx.toInt();
        remainX = dx - idx;

        int idy = dy.toInt();
        remainY = dy - idy;

        var handler = widget.onPanUpdate;
        if (handler != null) {
          if (idx.abs() > 0 || idy.abs() > 0) {
            var newEvent = DragUpdateDetails(
              globalPosition: event.globalPosition,
              localPosition: event.localPosition,
              sourceTimeStamp: event.sourceTimeStamp,
              delta: Offset(idx.toDouble(), idy.toDouble()),
              primaryDelta: event.primaryDelta,
              kind: event.kind,
            );
            handler(newEvent);
          }
        }
      },
      child: widget.child,
    );
  }
}
