import 'package:displacerc/components/dp_status_bar.dart';
import 'package:displacerc/screens/main/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DpPage extends ConsumerStatefulWidget {
  final Key? scaffoldKey;
  final Widget body;
  final Widget? drawer;
  final bool? drawerEnableOpenDragGesture;
  final Widget? bottomSheet;

  const DpPage({
    super.key,
    this.scaffoldKey,
    required this.body,
    this.drawer,
    this.drawerEnableOpenDragGesture,
    this.bottomSheet,
  });

  @override
  ConsumerState<DpPage> createState() => _DpPageState();
}

class _DpPageState extends ConsumerState<DpPage> {
  @override
  Widget build(BuildContext context) {
    final mainState = ref.watch(mainProvider);

    return Scaffold(
      key: widget.scaffoldKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            if (mainState.showStatusBar) DpStatusBar(),
            Expanded(child: widget.body),
          ],
        ),
      ),
      drawer: widget.drawer,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture ?? false,
      bottomSheet: widget.bottomSheet,
    );
  }
}
