import 'package:displacerc/components/dp_page.dart';
import 'package:displacerc/components/dp_text_button_white.dart';
import 'package:displacerc/constants/app_sizes.dart';
import 'package:displacerc/core/ble/ble_state.dart';
import 'package:displacerc/core/db/db_provider.dart';
import 'package:displacerc/core/screen/screen_providers.dart';
import 'package:displacerc/screens/main/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../core/ble/ble_providers.dart';

class ScreenSuccessfullyPaired extends StatefulWidget {
  const ScreenSuccessfullyPaired({super.key});

  @override
  State<ScreenSuccessfullyPaired> createState() =>
      _ScreenSuccessfullyPairedState();
}

class _ScreenSuccessfullyPairedState extends State<ScreenSuccessfullyPaired> {
  final TextEditingController _nameController = TextEditingController();
  late final FocusNode _nameFocusNode;

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DpPage(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check),
              const Gap(AppSizes.gap),
              const Text("Successfully paired.", style: TextStyle(color: Color(0xFFB2ABAB)),),
            ],
          ),
          const Gap(AppSizes.scanGap),
          const Text("Let's name this Displace TV.", style: TextStyle(color: Color(0xFFB2ABAB))),
          const Gap(AppSizes.scanGap),
          FractionallySizedBox(
            widthFactor: 0.7,
            child: TextField(
              textCapitalization: TextCapitalization.words,
              controller: _nameController,
              focusNode: _nameFocusNode,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFB2ABAB).withAlpha((255 * 65 / 100).round()),
                  ),
                ),
                hintText: 'Enter a name for this TV',
                hintStyle: TextStyle(color: Color(0xffB2ABAB).withAlpha((255 * 65 / 100).round())),
              ),
              onChanged: (_) =>
                  setState(() {}), // rebuild to toggle button enabled state
            ),
          ),
          const Gap(AppSizes.scanGap),
          Consumer(
            builder: (context, ref, child) {
              final bleState = ref.watch(bleControllerProvider);
              // final bleController = ref.read(bleControllerProvider.notifier);
              // final mainState = ref.watch(mainProvider);
              final mainController = ref.read(mainProvider.notifier);
              final screenController = ref.read(
                screenControllerProvider.notifier,
              );
              final db = ref.read(dbProvider);

              return DpTextButtonWhite(
                onPressed: _nameController.text.trim().isEmpty
                    ? null
                    : () async {
                        var current = bleState;
                        if (current is! BlePaired) {
                          throw Exception('BLE not in paired state');
                        }

                        var name = _nameController.text.trim();

                        /* await db.upsertBleDevice(
                          id: 'Abc',
                          name: "Test device",
                          tvCode: "1234",
                          pairingCode: "5678",
                          isActivated: false,
                        ); */

                        await db.deactivateAllBleDevices();

                        await db.upsertBleDevice(
                          id: current.remoteId,
                          name: name,
                          tvCode: current.tvCode,
                          pairingCode: current.pairingCode,
                          isActivated: true,
                        );

                        mainController.setActiveDeviceName(name);
                        screenController.gotoMain();
                        
                      },
                child: const Text("Done"),
              );
            },
          ),
        ],
      ),
    );
  }
}
