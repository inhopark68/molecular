// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ExperimentRecordsTable extends ExperimentRecords
    with TableInfo<$ExperimentRecordsTable, ExperimentRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExperimentRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _moduleMeta = const VerificationMeta('module');
  @override
  late final GeneratedColumn<String> module = GeneratedColumn<String>(
      'module', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _objectiveMeta =
      const VerificationMeta('objective');
  @override
  late final GeneratedColumn<String> objective = GeneratedColumn<String>(
      'objective', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sampleIdMeta =
      const VerificationMeta('sampleId');
  @override
  late final GeneratedColumn<String> sampleId = GeneratedColumn<String>(
      'sample_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, module, title, objective, sampleId, notes, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'experiment_records';
  @override
  VerificationContext validateIntegrity(Insertable<ExperimentRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('module')) {
      context.handle(_moduleMeta,
          module.isAcceptableOrUnknown(data['module']!, _moduleMeta));
    } else if (isInserting) {
      context.missing(_moduleMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('objective')) {
      context.handle(_objectiveMeta,
          objective.isAcceptableOrUnknown(data['objective']!, _objectiveMeta));
    }
    if (data.containsKey('sample_id')) {
      context.handle(_sampleIdMeta,
          sampleId.isAcceptableOrUnknown(data['sample_id']!, _sampleIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExperimentRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExperimentRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      module: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}module'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      objective: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}objective']),
      sampleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sample_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ExperimentRecordsTable createAlias(String alias) {
    return $ExperimentRecordsTable(attachedDatabase, alias);
  }
}

class ExperimentRecord extends DataClass
    implements Insertable<ExperimentRecord> {
  final int id;
  final String module;
  final String title;
  final String? objective;
  final String? sampleId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExperimentRecord(
      {required this.id,
      required this.module,
      required this.title,
      this.objective,
      this.sampleId,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['module'] = Variable<String>(module);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || objective != null) {
      map['objective'] = Variable<String>(objective);
    }
    if (!nullToAbsent || sampleId != null) {
      map['sample_id'] = Variable<String>(sampleId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExperimentRecordsCompanion toCompanion(bool nullToAbsent) {
    return ExperimentRecordsCompanion(
      id: Value(id),
      module: Value(module),
      title: Value(title),
      objective: objective == null && nullToAbsent
          ? const Value.absent()
          : Value(objective),
      sampleId: sampleId == null && nullToAbsent
          ? const Value.absent()
          : Value(sampleId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExperimentRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExperimentRecord(
      id: serializer.fromJson<int>(json['id']),
      module: serializer.fromJson<String>(json['module']),
      title: serializer.fromJson<String>(json['title']),
      objective: serializer.fromJson<String?>(json['objective']),
      sampleId: serializer.fromJson<String?>(json['sampleId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'module': serializer.toJson<String>(module),
      'title': serializer.toJson<String>(title),
      'objective': serializer.toJson<String?>(objective),
      'sampleId': serializer.toJson<String?>(sampleId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExperimentRecord copyWith(
          {int? id,
          String? module,
          String? title,
          Value<String?> objective = const Value.absent(),
          Value<String?> sampleId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ExperimentRecord(
        id: id ?? this.id,
        module: module ?? this.module,
        title: title ?? this.title,
        objective: objective.present ? objective.value : this.objective,
        sampleId: sampleId.present ? sampleId.value : this.sampleId,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ExperimentRecord copyWithCompanion(ExperimentRecordsCompanion data) {
    return ExperimentRecord(
      id: data.id.present ? data.id.value : this.id,
      module: data.module.present ? data.module.value : this.module,
      title: data.title.present ? data.title.value : this.title,
      objective: data.objective.present ? data.objective.value : this.objective,
      sampleId: data.sampleId.present ? data.sampleId.value : this.sampleId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExperimentRecord(')
          ..write('id: $id, ')
          ..write('module: $module, ')
          ..write('title: $title, ')
          ..write('objective: $objective, ')
          ..write('sampleId: $sampleId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, module, title, objective, sampleId, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExperimentRecord &&
          other.id == this.id &&
          other.module == this.module &&
          other.title == this.title &&
          other.objective == this.objective &&
          other.sampleId == this.sampleId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExperimentRecordsCompanion extends UpdateCompanion<ExperimentRecord> {
  final Value<int> id;
  final Value<String> module;
  final Value<String> title;
  final Value<String?> objective;
  final Value<String?> sampleId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ExperimentRecordsCompanion({
    this.id = const Value.absent(),
    this.module = const Value.absent(),
    this.title = const Value.absent(),
    this.objective = const Value.absent(),
    this.sampleId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ExperimentRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String module,
    required String title,
    this.objective = const Value.absent(),
    this.sampleId = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : module = Value(module),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ExperimentRecord> custom({
    Expression<int>? id,
    Expression<String>? module,
    Expression<String>? title,
    Expression<String>? objective,
    Expression<String>? sampleId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (module != null) 'module': module,
      if (title != null) 'title': title,
      if (objective != null) 'objective': objective,
      if (sampleId != null) 'sample_id': sampleId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ExperimentRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? module,
      Value<String>? title,
      Value<String?>? objective,
      Value<String?>? sampleId,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ExperimentRecordsCompanion(
      id: id ?? this.id,
      module: module ?? this.module,
      title: title ?? this.title,
      objective: objective ?? this.objective,
      sampleId: sampleId ?? this.sampleId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (module.present) {
      map['module'] = Variable<String>(module.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (objective.present) {
      map['objective'] = Variable<String>(objective.value);
    }
    if (sampleId.present) {
      map['sample_id'] = Variable<String>(sampleId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExperimentRecordsCompanion(')
          ..write('id: $id, ')
          ..write('module: $module, ')
          ..write('title: $title, ')
          ..write('objective: $objective, ')
          ..write('sampleId: $sampleId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExperimentRecordsTable experimentRecords =
      $ExperimentRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [experimentRecords];
}

typedef $$ExperimentRecordsTableCreateCompanionBuilder
    = ExperimentRecordsCompanion Function({
  Value<int> id,
  required String module,
  required String title,
  Value<String?> objective,
  Value<String?> sampleId,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$ExperimentRecordsTableUpdateCompanionBuilder
    = ExperimentRecordsCompanion Function({
  Value<int> id,
  Value<String> module,
  Value<String> title,
  Value<String?> objective,
  Value<String?> sampleId,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$ExperimentRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ExperimentRecordsTable> {
  $$ExperimentRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get module => $composableBuilder(
      column: $table.module, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get objective => $composableBuilder(
      column: $table.objective, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sampleId => $composableBuilder(
      column: $table.sampleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ExperimentRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExperimentRecordsTable> {
  $$ExperimentRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get module => $composableBuilder(
      column: $table.module, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get objective => $composableBuilder(
      column: $table.objective, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sampleId => $composableBuilder(
      column: $table.sampleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ExperimentRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExperimentRecordsTable> {
  $$ExperimentRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get module =>
      $composableBuilder(column: $table.module, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get objective =>
      $composableBuilder(column: $table.objective, builder: (column) => column);

  GeneratedColumn<String> get sampleId =>
      $composableBuilder(column: $table.sampleId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExperimentRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExperimentRecordsTable,
    ExperimentRecord,
    $$ExperimentRecordsTableFilterComposer,
    $$ExperimentRecordsTableOrderingComposer,
    $$ExperimentRecordsTableAnnotationComposer,
    $$ExperimentRecordsTableCreateCompanionBuilder,
    $$ExperimentRecordsTableUpdateCompanionBuilder,
    (
      ExperimentRecord,
      BaseReferences<_$AppDatabase, $ExperimentRecordsTable, ExperimentRecord>
    ),
    ExperimentRecord,
    PrefetchHooks Function()> {
  $$ExperimentRecordsTableTableManager(
      _$AppDatabase db, $ExperimentRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExperimentRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExperimentRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExperimentRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> module = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> objective = const Value.absent(),
            Value<String?> sampleId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ExperimentRecordsCompanion(
            id: id,
            module: module,
            title: title,
            objective: objective,
            sampleId: sampleId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String module,
            required String title,
            Value<String?> objective = const Value.absent(),
            Value<String?> sampleId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              ExperimentRecordsCompanion.insert(
            id: id,
            module: module,
            title: title,
            objective: objective,
            sampleId: sampleId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExperimentRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExperimentRecordsTable,
    ExperimentRecord,
    $$ExperimentRecordsTableFilterComposer,
    $$ExperimentRecordsTableOrderingComposer,
    $$ExperimentRecordsTableAnnotationComposer,
    $$ExperimentRecordsTableCreateCompanionBuilder,
    $$ExperimentRecordsTableUpdateCompanionBuilder,
    (
      ExperimentRecord,
      BaseReferences<_$AppDatabase, $ExperimentRecordsTable, ExperimentRecord>
    ),
    ExperimentRecord,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExperimentRecordsTableTableManager get experimentRecords =>
      $$ExperimentRecordsTableTableManager(_db, _db.experimentRecords);
}
