// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BleDevicesTable extends BleDevices
    with TableInfo<$BleDevicesTable, BleDevice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BleDevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tvCodeMeta = const VerificationMeta('tvCode');
  @override
  late final GeneratedColumn<String> tvCode = GeneratedColumn<String>(
    'tv_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pairingCodeMeta = const VerificationMeta(
    'pairingCode',
  );
  @override
  late final GeneratedColumn<String> pairingCode = GeneratedColumn<String>(
    'pairing_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActivatedMeta = const VerificationMeta(
    'isActivated',
  );
  @override
  late final GeneratedColumn<bool> isActivated = GeneratedColumn<bool>(
    'is_activated',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_activated" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
    'last_seen',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    tvCode,
    pairingCode,
    isActivated,
    lastSeen,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ble_devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<BleDevice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tv_code')) {
      context.handle(
        _tvCodeMeta,
        tvCode.isAcceptableOrUnknown(data['tv_code']!, _tvCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_tvCodeMeta);
    }
    if (data.containsKey('pairing_code')) {
      context.handle(
        _pairingCodeMeta,
        pairingCode.isAcceptableOrUnknown(
          data['pairing_code']!,
          _pairingCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pairingCodeMeta);
    }
    if (data.containsKey('is_activated')) {
      context.handle(
        _isActivatedMeta,
        isActivated.isAcceptableOrUnknown(
          data['is_activated']!,
          _isActivatedMeta,
        ),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BleDevice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BleDevice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      tvCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tv_code'],
      )!,
      pairingCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pairing_code'],
      )!,
      isActivated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_activated'],
      )!,
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen'],
      )!,
    );
  }

  @override
  $BleDevicesTable createAlias(String alias) {
    return $BleDevicesTable(attachedDatabase, alias);
  }
}

class BleDevice extends DataClass implements Insertable<BleDevice> {
  final String id;
  final String name;
  final String tvCode;
  final String pairingCode;
  final bool isActivated;
  final DateTime lastSeen;
  const BleDevice({
    required this.id,
    required this.name,
    required this.tvCode,
    required this.pairingCode,
    required this.isActivated,
    required this.lastSeen,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['tv_code'] = Variable<String>(tvCode);
    map['pairing_code'] = Variable<String>(pairingCode);
    map['is_activated'] = Variable<bool>(isActivated);
    map['last_seen'] = Variable<DateTime>(lastSeen);
    return map;
  }

  BleDevicesCompanion toCompanion(bool nullToAbsent) {
    return BleDevicesCompanion(
      id: Value(id),
      name: Value(name),
      tvCode: Value(tvCode),
      pairingCode: Value(pairingCode),
      isActivated: Value(isActivated),
      lastSeen: Value(lastSeen),
    );
  }

  factory BleDevice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BleDevice(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      tvCode: serializer.fromJson<String>(json['tvCode']),
      pairingCode: serializer.fromJson<String>(json['pairingCode']),
      isActivated: serializer.fromJson<bool>(json['isActivated']),
      lastSeen: serializer.fromJson<DateTime>(json['lastSeen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'tvCode': serializer.toJson<String>(tvCode),
      'pairingCode': serializer.toJson<String>(pairingCode),
      'isActivated': serializer.toJson<bool>(isActivated),
      'lastSeen': serializer.toJson<DateTime>(lastSeen),
    };
  }

  BleDevice copyWith({
    String? id,
    String? name,
    String? tvCode,
    String? pairingCode,
    bool? isActivated,
    DateTime? lastSeen,
  }) => BleDevice(
    id: id ?? this.id,
    name: name ?? this.name,
    tvCode: tvCode ?? this.tvCode,
    pairingCode: pairingCode ?? this.pairingCode,
    isActivated: isActivated ?? this.isActivated,
    lastSeen: lastSeen ?? this.lastSeen,
  );
  BleDevice copyWithCompanion(BleDevicesCompanion data) {
    return BleDevice(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      tvCode: data.tvCode.present ? data.tvCode.value : this.tvCode,
      pairingCode: data.pairingCode.present
          ? data.pairingCode.value
          : this.pairingCode,
      isActivated: data.isActivated.present
          ? data.isActivated.value
          : this.isActivated,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BleDevice(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tvCode: $tvCode, ')
          ..write('pairingCode: $pairingCode, ')
          ..write('isActivated: $isActivated, ')
          ..write('lastSeen: $lastSeen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, tvCode, pairingCode, isActivated, lastSeen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BleDevice &&
          other.id == this.id &&
          other.name == this.name &&
          other.tvCode == this.tvCode &&
          other.pairingCode == this.pairingCode &&
          other.isActivated == this.isActivated &&
          other.lastSeen == this.lastSeen);
}

class BleDevicesCompanion extends UpdateCompanion<BleDevice> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> tvCode;
  final Value<String> pairingCode;
  final Value<bool> isActivated;
  final Value<DateTime> lastSeen;
  final Value<int> rowid;
  const BleDevicesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.tvCode = const Value.absent(),
    this.pairingCode = const Value.absent(),
    this.isActivated = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BleDevicesCompanion.insert({
    required String id,
    required String name,
    required String tvCode,
    required String pairingCode,
    this.isActivated = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       tvCode = Value(tvCode),
       pairingCode = Value(pairingCode);
  static Insertable<BleDevice> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? tvCode,
    Expression<String>? pairingCode,
    Expression<bool>? isActivated,
    Expression<DateTime>? lastSeen,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (tvCode != null) 'tv_code': tvCode,
      if (pairingCode != null) 'pairing_code': pairingCode,
      if (isActivated != null) 'is_activated': isActivated,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BleDevicesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? tvCode,
    Value<String>? pairingCode,
    Value<bool>? isActivated,
    Value<DateTime>? lastSeen,
    Value<int>? rowid,
  }) {
    return BleDevicesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      tvCode: tvCode ?? this.tvCode,
      pairingCode: pairingCode ?? this.pairingCode,
      isActivated: isActivated ?? this.isActivated,
      lastSeen: lastSeen ?? this.lastSeen,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tvCode.present) {
      map['tv_code'] = Variable<String>(tvCode.value);
    }
    if (pairingCode.present) {
      map['pairing_code'] = Variable<String>(pairingCode.value);
    }
    if (isActivated.present) {
      map['is_activated'] = Variable<bool>(isActivated.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BleDevicesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tvCode: $tvCode, ')
          ..write('pairingCode: $pairingCode, ')
          ..write('isActivated: $isActivated, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BleDevicesTable bleDevices = $BleDevicesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bleDevices];
}

typedef $$BleDevicesTableCreateCompanionBuilder =
    BleDevicesCompanion Function({
      required String id,
      required String name,
      required String tvCode,
      required String pairingCode,
      Value<bool> isActivated,
      Value<DateTime> lastSeen,
      Value<int> rowid,
    });
typedef $$BleDevicesTableUpdateCompanionBuilder =
    BleDevicesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> tvCode,
      Value<String> pairingCode,
      Value<bool> isActivated,
      Value<DateTime> lastSeen,
      Value<int> rowid,
    });

class $$BleDevicesTableFilterComposer
    extends Composer<_$AppDatabase, $BleDevicesTable> {
  $$BleDevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tvCode => $composableBuilder(
    column: $table.tvCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pairingCode => $composableBuilder(
    column: $table.pairingCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActivated => $composableBuilder(
    column: $table.isActivated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BleDevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $BleDevicesTable> {
  $$BleDevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tvCode => $composableBuilder(
    column: $table.tvCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pairingCode => $composableBuilder(
    column: $table.pairingCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActivated => $composableBuilder(
    column: $table.isActivated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BleDevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BleDevicesTable> {
  $$BleDevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get tvCode =>
      $composableBuilder(column: $table.tvCode, builder: (column) => column);

  GeneratedColumn<String> get pairingCode => $composableBuilder(
    column: $table.pairingCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActivated => $composableBuilder(
    column: $table.isActivated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);
}

class $$BleDevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BleDevicesTable,
          BleDevice,
          $$BleDevicesTableFilterComposer,
          $$BleDevicesTableOrderingComposer,
          $$BleDevicesTableAnnotationComposer,
          $$BleDevicesTableCreateCompanionBuilder,
          $$BleDevicesTableUpdateCompanionBuilder,
          (
            BleDevice,
            BaseReferences<_$AppDatabase, $BleDevicesTable, BleDevice>,
          ),
          BleDevice,
          PrefetchHooks Function()
        > {
  $$BleDevicesTableTableManager(_$AppDatabase db, $BleDevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BleDevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BleDevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BleDevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> tvCode = const Value.absent(),
                Value<String> pairingCode = const Value.absent(),
                Value<bool> isActivated = const Value.absent(),
                Value<DateTime> lastSeen = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BleDevicesCompanion(
                id: id,
                name: name,
                tvCode: tvCode,
                pairingCode: pairingCode,
                isActivated: isActivated,
                lastSeen: lastSeen,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String tvCode,
                required String pairingCode,
                Value<bool> isActivated = const Value.absent(),
                Value<DateTime> lastSeen = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BleDevicesCompanion.insert(
                id: id,
                name: name,
                tvCode: tvCode,
                pairingCode: pairingCode,
                isActivated: isActivated,
                lastSeen: lastSeen,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BleDevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BleDevicesTable,
      BleDevice,
      $$BleDevicesTableFilterComposer,
      $$BleDevicesTableOrderingComposer,
      $$BleDevicesTableAnnotationComposer,
      $$BleDevicesTableCreateCompanionBuilder,
      $$BleDevicesTableUpdateCompanionBuilder,
      (BleDevice, BaseReferences<_$AppDatabase, $BleDevicesTable, BleDevice>),
      BleDevice,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BleDevicesTableTableManager get bleDevices =>
      $$BleDevicesTableTableManager(_db, _db.bleDevices);
}
