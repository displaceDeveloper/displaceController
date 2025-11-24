import 'package:displacerc/components/dp_page.dart';
import 'package:displacerc/constants/app_colors.dart';
import 'package:displacerc/constants/app_sizes.dart';
import 'package:displacerc/core/ble/ble_state.dart';
import 'package:displacerc/core/logger.dart';
import 'package:displacerc/core/screen/screen_providers.dart';
import 'package:displacerc/core/screen/screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../core/ble/ble_providers.dart';

class ScreenScanQr extends StatefulWidget {
  const ScreenScanQr({super.key});

  @override
  State<ScreenScanQr> createState() => _ScreenScanQrState();
}

class _ScreenScanQrState extends State<ScreenScanQr> {
  bool alreadySentConnect = false;

  @override
  void initState() {
    super.initState();
    alreadySentConnect = false;
  }

  @override
  Widget build(BuildContext context) {
    return DpPage(
      body: Consumer(
        builder: (context, ref, _) {
          var screenState =
              ref.read(screenControllerProvider) as ScreenStateScanQr;

          var screenController = ref.read(screenControllerProvider.notifier);

          return Column(
            children: [
              Gap(AppSizes.scanMargin),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.tv),
                  Gap(AppSizes.gap),
                  Text("Pair this controller with Displace TV"),
                ],
              ),
              Gap(AppSizes.scanGap),
              const Text(
                "Scan the QR code displayed on the TV.",
                style: TextStyle(color: AppColors.grayTextColor),
              ),
              Gap(AppSizes.scanGap),

              FractionallySizedBox(
                widthFactor: 0.95,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: _qrComponent(ref),
                  ),
                ),
              ),
              Expanded(child: Container()),
              const Text(
                "Press the button inside the\nright handle of the TV to reveal QR code.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grayTextColor),
              ),

              if (screenState.cancelable)
                Gap(AppSizes.gap),

              if (screenState.cancelable)
                FilledButton(
                  onPressed: () {
                    screenController.gotoMain(reconnectDeviceId: null);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFF1F1D1D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Cancel", style: TextStyle(color: Colors.white),),
                ),
              Gap(AppSizes.scanMargin),
            ],
          );
        },
      ),
    );
  }

  Widget _qrComponent(WidgetRef ref) {
    final bleController = ref.read(bleControllerProvider.notifier);

    final screenState = ref.watch(screenControllerProvider) as ScreenStateScanQr;
    final screenController = ref.read(screenControllerProvider.notifier);

    final MobileScannerController controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      // autoZoom: true
    );

    if (bleController.isProduction()) {
      return MobileScanner(
        controller: controller,
        onDetect: (result) {
          logSys.info("Found: ${result.barcodes.first.rawValue}");
          String code = result.barcodes.first.rawValue ?? "";
          if (code.isEmpty) {
            return;
          }

          if (!alreadySentConnect) {
            String tvCode = code.split(":")[1];

            if (!bleController.isScanning()) {
              bleController.startScan();
            }

            bleController.connect(tvCode: tvCode);
            screenController.gotoPairing(cancelable: screenState.cancelable);

            alreadySentConnect = true;
          }
        },
      );
    }

    if (!alreadySentConnect) {
      // This is fake mode, simulate a scan after 3 seconds
      alreadySentConnect = true;

      logBle.info("Simulating QR scan in 3 seconds...");
      Future.delayed(const Duration(seconds: 3), () {
        // bleController.setConnectionInfo(tvCode: 'Dummy', pairingCode: '');
        bleController.connect(tvCode: 'Dummy');
        screenController.gotoPairing(cancelable: screenState.cancelable);
      });
    }

    return Container(color: const Color(0xFFD9D9D9));
  }
}
