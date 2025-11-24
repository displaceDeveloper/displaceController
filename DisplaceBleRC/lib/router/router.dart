import 'package:displacerc/core/screen/screen_providers.dart';
import 'package:displacerc/core/screen/screen_state.dart';
import 'package:displacerc/screens/main/screen_main.dart';
import 'package:displacerc/screens/pairing/screen_failed_pairing.dart';
import 'package:displacerc/screens/pairing/screen_pairing.dart';
import 'package:displacerc/screens/pairing/screen_successfully_paired.dart';
import 'package:displacerc/screens/permissions/screen_permissions.dart';
import 'package:displacerc/screens/scanqr/screen_scanqr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'router_notifier.dart';

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  final notifier = RouterNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});

final routerProvider = Provider<GoRouter>((ref) {
  final routerNotifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    initialLocation: '/permissions',
    refreshListenable: routerNotifier, // quan trọng

    routes: [
      GoRoute(
        path: '/permissions',
        builder: (context, state) => const ScreenPermissions(),
      ),
      GoRoute(path: '/scan', builder: (context, state) => const ScreenScanQr()),
      GoRoute(
        path: '/pairing',
        builder: (context, state) => const ScreenPairing(),
      ),
      GoRoute(
        path: '/failed_pairing',
        builder: (context, state) => const ScreenFailedPairing(),
      ),
      GoRoute(
        path: '/paired',
        builder: (context, state) => const ScreenSuccessfullyPaired(),
      ),
      GoRoute(path: '/main', builder: (context, state) => ScreenMain()),
    ],

    redirect: (context, state) {
      final screenState = ref.watch(screenControllerProvider);

      final onPermissions = state.matchedLocation == '/permissions';
      final onScan = state.matchedLocation == '/scan';
      final onPairing = state.matchedLocation == '/pairing';
      final onFailedPairing = state.matchedLocation == '/failed_pairing';
      final onSuccessfullyPaired = state.matchedLocation == '/paired';
      final onMain = state.matchedLocation == '/main';

      if (screenState is ScreenStatePermissions) {
        if (!onPermissions) return '/permissions';
      }

      if (screenState is ScreenStateScanQr) {
        if (!onScan) return '/scan';
      }

      if (screenState is ScreenStatePairing) {
        if (!onPairing) return '/pairing';
      }

      if (screenState is ScreenStatePairError) {
        if (!onFailedPairing) return '/failed_pairing';
      }

      if (screenState is ScreenStateSuccessfullyPaired) {
        if (!onSuccessfullyPaired) return '/paired';
      }

      if (screenState is ScreenStateMain) {
        if (!onMain) return '/main';
      }

      // Don't need to redirect at all
      return null;
    },
  );
});
