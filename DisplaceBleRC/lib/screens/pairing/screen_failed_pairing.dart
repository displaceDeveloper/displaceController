import 'package:displacerc/components/dp_page.dart';
import 'package:displacerc/constants/app_sizes.dart';
import 'package:displacerc/core/screen/screen_providers.dart';
import 'package:displacerc/core/screen/screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ScreenFailedPairing extends ConsumerWidget {
  const ScreenFailedPairing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenState =
        ref.watch(screenControllerProvider) as ScreenStatePairError;
    var screenController = ref.read(screenControllerProvider.notifier);

    return DpPage(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Could not pair with Displace TV'),
            Gap(AppSizes.gap),
            SizedBox(
              width: 150,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  screenController.gotoScan(cancelable: false);
                },
                child: Text("Try Again"),
              ),
            ),
            Gap(AppSizes.gap),
            SizedBox(
              width: 150,
              child: FilledButton(
                onPressed: () {
                  screenController.gotoScan(cancelable: screenState.cancelable);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xFF1F1D1D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Cancel", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
