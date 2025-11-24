import 'package:displacerc/core/db/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final bleDevicesStreamProvider = StreamProvider<List<BleDevice>>((ref) {
  final db = ref.watch(dbProvider);
  return db.watchAllBleDevices();
});
