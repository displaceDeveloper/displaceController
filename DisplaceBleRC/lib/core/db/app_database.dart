import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

class BleDevices extends Table {
  TextColumn get id => text()(); // primary key
  TextColumn get name => text().withLength(min: 1, max: 128)();
  // TextColumn get address => text()();
  TextColumn get tvCode => text()();
  TextColumn get pairingCode => text()();
  BoolColumn get isActivated => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSeen =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [BleDevices])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  // ===== BLE CRUD API =====

  Future<bool> hasAnyBleDevice() async {
    final countExp = bleDevices.id.count();
    final query = selectOnly(bleDevices)..addColumns([countExp]);
    final result = await query.getSingle();
    final count = result.read(countExp) ?? 0;
    return count > 0;
  }

  Future<List<BleDevice>> getAllBleDevices() {
    return select(bleDevices).get();
  }

  Future<BleDevice?> getBleDeviceById(String id) {
    return (select(
      bleDevices,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<BleDevice?> getActiveBleDevice() {
    return (select(
      bleDevices,
    )..where((tbl) => tbl.isActivated.equals(true))).getSingleOrNull();
  }

  Future<List<BleDevice>> getInActiveBleDevices() {
    return (select(
      bleDevices,
    )..where((tbl) => tbl.isActivated.equals(false))).get();
  }

  Future<void> deactivateAllBleDevices() async {
    await (update(bleDevices)..where((tbl) => tbl.isActivated.equals(true)))
        .write(const BleDevicesCompanion(isActivated: Value(false)));
  }

  /// Insert/update (upsert) 1 device
  Future<void> upsertBleDevice({
    required String id,
    required String name,
    // required String address,
    required String tvCode,
    required String pairingCode,
    required bool isActivated,
  }) async {
    into(bleDevices).insertOnConflictUpdate(
      BleDevicesCompanion.insert(
        id: id,
        name: name,
        // address: address,
        tvCode: tvCode,
        pairingCode: pairingCode,
        isActivated: Value(isActivated),
      ),
    );
  }

  Future<void> updateBleDevice(String id, {String? name, bool? isActive}) async {
    await (update(bleDevices)..where((tbl) => tbl.id.equals(id))).write(
      BleDevicesCompanion(
        name: name == null ? const Value.absent() : Value(name),
        isActivated:
            isActive == null ? const Value.absent() : Value(isActive),
      ),
    );
  }

  Future<int> deleteBleDevice(String id) {
    return (delete(bleDevices)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> clearBleDevices() {
    return delete(bleDevices).go();
  }

  Stream<List<BleDevice>> watchAllBleDevices() {
  return (select(bleDevices)
        ..orderBy([(tbl) => OrderingTerm.desc(tbl.lastSeen)]))
      .watch();
}
}

// ====== Connection helper ======

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
