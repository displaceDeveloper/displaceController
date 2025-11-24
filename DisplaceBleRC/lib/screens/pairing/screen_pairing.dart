import 'package:displacerc/components/dp_page.dart';
import 'package:displacerc/components/dp_text_button.dart';
import 'package:displacerc/constants/app_sizes.dart';
import 'package:displacerc/core/ble/ble_providers.dart';
import 'package:displacerc/core/ble/ble_state.dart';
import 'package:displacerc/core/screen/screen_providers.dart';
import 'package:displacerc/core/screen/screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ScreenPairing extends ConsumerWidget {
  const ScreenPairing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var bleState = ref.watch(bleControllerProvider);
    var screenState = ref.watch(screenControllerProvider) as ScreenStatePairing;
    var screenController = ref.read(screenControllerProvider.notifier);

    if (bleState is BlePaired) {
      Future.microtask(() {
        screenController.gotoSuccessfullyPaired();
      });
    } else if (bleState is BleFailedPairing) {
      Future.microtask(() {
        screenController.gotoPairError(cancelable: screenState.cancelable);
      });
    }

    return DpPage(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Pairing...'),
                ],
              ),
            ),
          ),

          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 200),
            child: DpTextButton(
              onPressed: () {
                screenController.gotoScan(cancelable: false);
              },
              child: Text('Cancel'),
            ),
          ),
          Gap(AppSizes.scanMargin),
        ],
      ),
    );
  }
}
