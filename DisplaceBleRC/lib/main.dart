import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:displacerc/core/ble/ble_providers.dart';
import 'package:displacerc/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.loggerName}: ${record.message}');
  });

  runApp(
    Platform.isAndroid
        ? _app()
        : DevicePreview(
            enabled: true,
            tools: const [...DevicePreview.defaultTools],
            builder: (context) => _app(),
          ),
  );
}

Widget _app() {
  return ProviderScope(child: MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    ref.read(appBootstrapProvider);

    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      routerConfig: router,
      title: 'DisplaceRC',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
