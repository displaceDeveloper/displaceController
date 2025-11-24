import 'package:displacerc/components/dp_page.dart';
import 'package:displacerc/core/db/db_provider.dart';
import 'package:displacerc/core/logger.dart';
import 'package:displacerc/core/screen/screen_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenPermissions extends ConsumerStatefulWidget {
  const ScreenPermissions({super.key});

  @override
  ConsumerState<ScreenPermissions> createState() => _ScreenPermissionsState();
}

class _ScreenPermissionsState extends ConsumerState<ScreenPermissions> {
  bool? cameraPermissionGranted;
  bool? locationPermissionGranted;
  bool? blePermissionGranted;
  bool? installPermissionGranted;

  @override
  void initState() {
    super.initState();

    getAllPermissions();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (cameraPermissionGranted == true &&
          locationPermissionGranted == true &&
          blePermissionGranted == true &&
          installPermissionGranted == true) {
        await processToNextPage();
      }
    });

    return DpPage(
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            if (cameraPermissionGranted == false)
              FilledButton(
                onPressed: cameraPermissionGranted != false
                    ? null
                    : () async {
                        await requestCameraPermission();
                      },
                child: Text("Request Camera Permission"),
              ),
            if (locationPermissionGranted == false)
              FilledButton(
                onPressed: locationPermissionGranted != false
                    ? null
                    : () async {
                        await requestLocationPermission();
                      },
                child: Text("Request Location Permission"),
              ),
            if (blePermissionGranted == false)
              FilledButton(
                onPressed: blePermissionGranted != false
                    ? null
                    : () async {
                        await requestBlePermission();
                      },
                child: Text("Request BLE Permission"),
              ),
            if (installPermissionGranted == false)
              FilledButton(
                onPressed: installPermissionGranted != false
                    ? null
                    : () async {
                        await requestInstallPermission();
                      },
                child: Text("Request Install Permission"),
              ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Future<void> getAllPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final locationStatus = await Permission.location.status;
    final bleStatus = await Permission.bluetooth.status;
    final installStatus = await Permission.requestInstallPackages.status;

    if (!mounted) return;

    setState(() {
      cameraPermissionGranted = cameraStatus.isGranted;
      locationPermissionGranted = locationStatus.isGranted;
      blePermissionGranted = bleStatus.isGranted;
      installPermissionGranted = installStatus.isGranted;
    });
  }

  Future<void> requestCameraPermission() async {
    logSys.info("Requesting camera permission...");

    if (cameraPermissionGranted == false) {
      final status = await Permission.camera.request();
      cameraPermissionGranted = status.isGranted;

      setState(() {});

      if (cameraPermissionGranted == true &&
          locationPermissionGranted == true &&
          blePermissionGranted == true &&
          installPermissionGranted == true) {
        await processToNextPage();
      }
    }
  }

  Future<void> requestLocationPermission() async {
    logSys.info("Requesting location permission...");

    if (locationPermissionGranted == false) {
      final status = await Permission.location.request();
      locationPermissionGranted = status.isGranted;

      setState(() {});

      if (cameraPermissionGranted == true &&
          locationPermissionGranted == true &&
          blePermissionGranted == true &&
          installPermissionGranted == true) {
        await processToNextPage();
      }
    }
  }

  Future<void> requestBlePermission() async {
    logSys.info("Requesting BLE permission...");

    if (blePermissionGranted == false) {
      final status = await Permission.bluetooth.request();
      blePermissionGranted = status.isGranted;

      setState(() {});

      if (cameraPermissionGranted == true &&
          locationPermissionGranted == true &&
          blePermissionGranted == true &&
          installPermissionGranted == true) {
        await processToNextPage();
      }
    }
  }

  Future<void> requestInstallPermission() async {
    logSys.info("Requesting install permission...");

    if (installPermissionGranted == false) {
      final status = await Permission.requestInstallPackages.request();
      installPermissionGranted = status.isGranted;

      setState(() {});

      if (cameraPermissionGranted == true &&
          locationPermissionGranted == true &&
          blePermissionGranted == true &&
          installPermissionGranted == true) {
        await processToNextPage();
      }
    }
  }

  Future<void> processToNextPage() async {
    var db = ref.read(dbProvider);
    var activeDevice = await db.getActiveBleDevice();
    var hasDevice = await db.hasAnyBleDevice();

    var stateController = ref.read(screenControllerProvider.notifier);
    if (!hasDevice) {
      stateController.gotoScan(cancelable: false);
      return;
    }

    stateController.gotoMain(reconnectDeviceId: activeDevice?.id);
  }
}
