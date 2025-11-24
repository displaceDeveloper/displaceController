// lib/router/router_notifier.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/ble/ble_state.dart';
import '../core/ble/ble_providers.dart';

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref) {
    ref.listen<BleState>(
      bleControllerProvider,
      (previous, next) => notifyListeners(),
    );
  }

  final Ref ref;
}