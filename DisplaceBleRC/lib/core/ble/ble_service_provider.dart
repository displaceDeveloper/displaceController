import 'dart:io';

import 'package:displacerc/core/ble/ble_service_real.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './ble_service.dart';
import './ble_service_fake.dart';

final bleServiceProvider = Provider<BleService>((ref) {
  // return BleServiceFake();
  
  if (Platform.isAndroid) {
    return BleServiceReal();
  }
  
  return BleServiceFake();
});
