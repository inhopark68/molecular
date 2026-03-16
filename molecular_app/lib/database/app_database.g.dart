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
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('General'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
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
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, module, title, notes, createdAt, updatedAt];
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
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
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
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExperimentRecord(
      {required this.id,
      required this.module,
      required this.title,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['module'] = Variable<String>(module);
    map['title'] = Variable<String>(title);
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
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExperimentRecord copyWith(
          {int? id,
          String? module,
          String? title,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      ExperimentRecord(
        id: id ?? this.id,
        module: module ?? this.module,
        title: title ?? this.title,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ExperimentRecord copyWithCompanion(ExperimentRecordsCompanion data) {
    return ExperimentRecord(
      id: data.id.present ? data.id.value : this.id,
      module: data.module.present ? data.module.value : this.module,
      title: data.title.present ? data.title.value : this.title,
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
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, module, title, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExperimentRecord &&
          other.id == this.id &&
          other.module == this.module &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExperimentRecordsCompanion extends UpdateCompanion<ExperimentRecord> {
  final Value<int> id;
  final Value<String> module;
  final Value<String> title;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ExperimentRecordsCompanion({
    this.id = const Value.absent(),
    this.module = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ExperimentRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.module = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<ExperimentRecord> custom({
    Expression<int>? id,
    Expression<String>? module,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (module != null) 'module': module,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ExperimentRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? module,
      Value<String>? title,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return ExperimentRecordsCompanion(
      id: id ?? this.id,
      module: module ?? this.module,
      title: title ?? this.title,
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
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CloningDetailsTable extends CloningDetails
    with TableInfo<$CloningDetailsTable, CloningDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CloningDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _experimentRecordIdMeta =
      const VerificationMeta('experimentRecordId');
  @override
  late final GeneratedColumn<int> experimentRecordId = GeneratedColumn<int>(
      'experiment_record_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cloningMethodMeta =
      const VerificationMeta('cloningMethod');
  @override
  late final GeneratedColumn<String> cloningMethod = GeneratedColumn<String>(
      'cloning_method', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _enzyme1Meta =
      const VerificationMeta('enzyme1');
  @override
  late final GeneratedColumn<String> enzyme1 = GeneratedColumn<String>(
      'enzyme1', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _enzyme2Meta =
      const VerificationMeta('enzyme2');
  @override
  late final GeneratedColumn<String> enzyme2 = GeneratedColumn<String>(
      'enzyme2', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vectorPlasmidIdMeta =
      const VerificationMeta('vectorPlasmidId');
  @override
  late final GeneratedColumn<int> vectorPlasmidId = GeneratedColumn<int>(
      'vector_plasmid_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _insertPlasmidIdMeta =
      const VerificationMeta('insertPlasmidId');
  @override
  late final GeneratedColumn<int> insertPlasmidId = GeneratedColumn<int>(
      'insert_plasmid_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _destinationPlasmidIdMeta =
      const VerificationMeta('destinationPlasmidId');
  @override
  late final GeneratedColumn<int> destinationPlasmidId = GeneratedColumn<int>(
      'destination_plasmid_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        experimentRecordId,
        cloningMethod,
        enzyme1,
        enzyme2,
        notes,
        vectorPlasmidId,
        insertPlasmidId,
        destinationPlasmidId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cloning_details';
  @override
  VerificationContext validateIntegrity(Insertable<CloningDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('experiment_record_id')) {
      context.handle(
          _experimentRecordIdMeta,
          experimentRecordId.isAcceptableOrUnknown(
              data['experiment_record_id']!, _experimentRecordIdMeta));
    } else if (isInserting) {
      context.missing(_experimentRecordIdMeta);
    }
    if (data.containsKey('cloning_method')) {
      context.handle(
          _cloningMethodMeta,
          cloningMethod.isAcceptableOrUnknown(
              data['cloning_method']!, _cloningMethodMeta));
    }
    if (data.containsKey('enzyme1')) {
      context.handle(_enzyme1Meta,
          enzyme1.isAcceptableOrUnknown(data['enzyme1']!, _enzyme1Meta));
    }
    if (data.containsKey('enzyme2')) {
      context.handle(_enzyme2Meta,
          enzyme2.isAcceptableOrUnknown(data['enzyme2']!, _enzyme2Meta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('vector_plasmid_id')) {
      context.handle(
          _vectorPlasmidIdMeta,
          vectorPlasmidId.isAcceptableOrUnknown(
              data['vector_plasmid_id']!, _vectorPlasmidIdMeta));
    }
    if (data.containsKey('insert_plasmid_id')) {
      context.handle(
          _insertPlasmidIdMeta,
          insertPlasmidId.isAcceptableOrUnknown(
              data['insert_plasmid_id']!, _insertPlasmidIdMeta));
    }
    if (data.containsKey('destination_plasmid_id')) {
      context.handle(
          _destinationPlasmidIdMeta,
          destinationPlasmidId.isAcceptableOrUnknown(
              data['destination_plasmid_id']!, _destinationPlasmidIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CloningDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CloningDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      experimentRecordId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}experiment_record_id'])!,
      cloningMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cloning_method']),
      enzyme1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}enzyme1']),
      enzyme2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}enzyme2']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      vectorPlasmidId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vector_plasmid_id']),
      insertPlasmidId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}insert_plasmid_id']),
      destinationPlasmidId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}destination_plasmid_id']),
    );
  }

  @override
  $CloningDetailsTable createAlias(String alias) {
    return $CloningDetailsTable(attachedDatabase, alias);
  }
}

class CloningDetail extends DataClass implements Insertable<CloningDetail> {
  final int id;
  final int experimentRecordId;
  final String? cloningMethod;
  final String? enzyme1;
  final String? enzyme2;
  final String? notes;
  final int? vectorPlasmidId;
  final int? insertPlasmidId;
  final int? destinationPlasmidId;
  const CloningDetail(
      {required this.id,
      required this.experimentRecordId,
      this.cloningMethod,
      this.enzyme1,
      this.enzyme2,
      this.notes,
      this.vectorPlasmidId,
      this.insertPlasmidId,
      this.destinationPlasmidId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['experiment_record_id'] = Variable<int>(experimentRecordId);
    if (!nullToAbsent || cloningMethod != null) {
      map['cloning_method'] = Variable<String>(cloningMethod);
    }
    if (!nullToAbsent || enzyme1 != null) {
      map['enzyme1'] = Variable<String>(enzyme1);
    }
    if (!nullToAbsent || enzyme2 != null) {
      map['enzyme2'] = Variable<String>(enzyme2);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || vectorPlasmidId != null) {
      map['vector_plasmid_id'] = Variable<int>(vectorPlasmidId);
    }
    if (!nullToAbsent || insertPlasmidId != null) {
      map['insert_plasmid_id'] = Variable<int>(insertPlasmidId);
    }
    if (!nullToAbsent || destinationPlasmidId != null) {
      map['destination_plasmid_id'] = Variable<int>(destinationPlasmidId);
    }
    return map;
  }

  CloningDetailsCompanion toCompanion(bool nullToAbsent) {
    return CloningDetailsCompanion(
      id: Value(id),
      experimentRecordId: Value(experimentRecordId),
      cloningMethod: cloningMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(cloningMethod),
      enzyme1: enzyme1 == null && nullToAbsent
          ? const Value.absent()
          : Value(enzyme1),
      enzyme2: enzyme2 == null && nullToAbsent
          ? const Value.absent()
          : Value(enzyme2),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      vectorPlasmidId: vectorPlasmidId == null && nullToAbsent
          ? const Value.absent()
          : Value(vectorPlasmidId),
      insertPlasmidId: insertPlasmidId == null && nullToAbsent
          ? const Value.absent()
          : Value(insertPlasmidId),
      destinationPlasmidId: destinationPlasmidId == null && nullToAbsent
          ? const Value.absent()
          : Value(destinationPlasmidId),
    );
  }

  factory CloningDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CloningDetail(
      id: serializer.fromJson<int>(json['id']),
      experimentRecordId: serializer.fromJson<int>(json['experimentRecordId']),
      cloningMethod: serializer.fromJson<String?>(json['cloningMethod']),
      enzyme1: serializer.fromJson<String?>(json['enzyme1']),
      enzyme2: serializer.fromJson<String?>(json['enzyme2']),
      notes: serializer.fromJson<String?>(json['notes']),
      vectorPlasmidId: serializer.fromJson<int?>(json['vectorPlasmidId']),
      insertPlasmidId: serializer.fromJson<int?>(json['insertPlasmidId']),
      destinationPlasmidId:
          serializer.fromJson<int?>(json['destinationPlasmidId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'experimentRecordId': serializer.toJson<int>(experimentRecordId),
      'cloningMethod': serializer.toJson<String?>(cloningMethod),
      'enzyme1': serializer.toJson<String?>(enzyme1),
      'enzyme2': serializer.toJson<String?>(enzyme2),
      'notes': serializer.toJson<String?>(notes),
      'vectorPlasmidId': serializer.toJson<int?>(vectorPlasmidId),
      'insertPlasmidId': serializer.toJson<int?>(insertPlasmidId),
      'destinationPlasmidId': serializer.toJson<int?>(destinationPlasmidId),
    };
  }

  CloningDetail copyWith(
          {int? id,
          int? experimentRecordId,
          Value<String?> cloningMethod = const Value.absent(),
          Value<String?> enzyme1 = const Value.absent(),
          Value<String?> enzyme2 = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<int?> vectorPlasmidId = const Value.absent(),
          Value<int?> insertPlasmidId = const Value.absent(),
          Value<int?> destinationPlasmidId = const Value.absent()}) =>
      CloningDetail(
        id: id ?? this.id,
        experimentRecordId: experimentRecordId ?? this.experimentRecordId,
        cloningMethod:
            cloningMethod.present ? cloningMethod.value : this.cloningMethod,
        enzyme1: enzyme1.present ? enzyme1.value : this.enzyme1,
        enzyme2: enzyme2.present ? enzyme2.value : this.enzyme2,
        notes: notes.present ? notes.value : this.notes,
        vectorPlasmidId: vectorPlasmidId.present
            ? vectorPlasmidId.value
            : this.vectorPlasmidId,
        insertPlasmidId: insertPlasmidId.present
            ? insertPlasmidId.value
            : this.insertPlasmidId,
        destinationPlasmidId: destinationPlasmidId.present
            ? destinationPlasmidId.value
            : this.destinationPlasmidId,
      );
  CloningDetail copyWithCompanion(CloningDetailsCompanion data) {
    return CloningDetail(
      id: data.id.present ? data.id.value : this.id,
      experimentRecordId: data.experimentRecordId.present
          ? data.experimentRecordId.value
          : this.experimentRecordId,
      cloningMethod: data.cloningMethod.present
          ? data.cloningMethod.value
          : this.cloningMethod,
      enzyme1: data.enzyme1.present ? data.enzyme1.value : this.enzyme1,
      enzyme2: data.enzyme2.present ? data.enzyme2.value : this.enzyme2,
      notes: data.notes.present ? data.notes.value : this.notes,
      vectorPlasmidId: data.vectorPlasmidId.present
          ? data.vectorPlasmidId.value
          : this.vectorPlasmidId,
      insertPlasmidId: data.insertPlasmidId.present
          ? data.insertPlasmidId.value
          : this.insertPlasmidId,
      destinationPlasmidId: data.destinationPlasmidId.present
          ? data.destinationPlasmidId.value
          : this.destinationPlasmidId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CloningDetail(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('cloningMethod: $cloningMethod, ')
          ..write('enzyme1: $enzyme1, ')
          ..write('enzyme2: $enzyme2, ')
          ..write('notes: $notes, ')
          ..write('vectorPlasmidId: $vectorPlasmidId, ')
          ..write('insertPlasmidId: $insertPlasmidId, ')
          ..write('destinationPlasmidId: $destinationPlasmidId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      experimentRecordId,
      cloningMethod,
      enzyme1,
      enzyme2,
      notes,
      vectorPlasmidId,
      insertPlasmidId,
      destinationPlasmidId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CloningDetail &&
          other.id == this.id &&
          other.experimentRecordId == this.experimentRecordId &&
          other.cloningMethod == this.cloningMethod &&
          other.enzyme1 == this.enzyme1 &&
          other.enzyme2 == this.enzyme2 &&
          other.notes == this.notes &&
          other.vectorPlasmidId == this.vectorPlasmidId &&
          other.insertPlasmidId == this.insertPlasmidId &&
          other.destinationPlasmidId == this.destinationPlasmidId);
}

class CloningDetailsCompanion extends UpdateCompanion<CloningDetail> {
  final Value<int> id;
  final Value<int> experimentRecordId;
  final Value<String?> cloningMethod;
  final Value<String?> enzyme1;
  final Value<String?> enzyme2;
  final Value<String?> notes;
  final Value<int?> vectorPlasmidId;
  final Value<int?> insertPlasmidId;
  final Value<int?> destinationPlasmidId;
  const CloningDetailsCompanion({
    this.id = const Value.absent(),
    this.experimentRecordId = const Value.absent(),
    this.cloningMethod = const Value.absent(),
    this.enzyme1 = const Value.absent(),
    this.enzyme2 = const Value.absent(),
    this.notes = const Value.absent(),
    this.vectorPlasmidId = const Value.absent(),
    this.insertPlasmidId = const Value.absent(),
    this.destinationPlasmidId = const Value.absent(),
  });
  CloningDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int experimentRecordId,
    this.cloningMethod = const Value.absent(),
    this.enzyme1 = const Value.absent(),
    this.enzyme2 = const Value.absent(),
    this.notes = const Value.absent(),
    this.vectorPlasmidId = const Value.absent(),
    this.insertPlasmidId = const Value.absent(),
    this.destinationPlasmidId = const Value.absent(),
  }) : experimentRecordId = Value(experimentRecordId);
  static Insertable<CloningDetail> custom({
    Expression<int>? id,
    Expression<int>? experimentRecordId,
    Expression<String>? cloningMethod,
    Expression<String>? enzyme1,
    Expression<String>? enzyme2,
    Expression<String>? notes,
    Expression<int>? vectorPlasmidId,
    Expression<int>? insertPlasmidId,
    Expression<int>? destinationPlasmidId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (experimentRecordId != null)
        'experiment_record_id': experimentRecordId,
      if (cloningMethod != null) 'cloning_method': cloningMethod,
      if (enzyme1 != null) 'enzyme1': enzyme1,
      if (enzyme2 != null) 'enzyme2': enzyme2,
      if (notes != null) 'notes': notes,
      if (vectorPlasmidId != null) 'vector_plasmid_id': vectorPlasmidId,
      if (insertPlasmidId != null) 'insert_plasmid_id': insertPlasmidId,
      if (destinationPlasmidId != null)
        'destination_plasmid_id': destinationPlasmidId,
    });
  }

  CloningDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? experimentRecordId,
      Value<String?>? cloningMethod,
      Value<String?>? enzyme1,
      Value<String?>? enzyme2,
      Value<String?>? notes,
      Value<int?>? vectorPlasmidId,
      Value<int?>? insertPlasmidId,
      Value<int?>? destinationPlasmidId}) {
    return CloningDetailsCompanion(
      id: id ?? this.id,
      experimentRecordId: experimentRecordId ?? this.experimentRecordId,
      cloningMethod: cloningMethod ?? this.cloningMethod,
      enzyme1: enzyme1 ?? this.enzyme1,
      enzyme2: enzyme2 ?? this.enzyme2,
      notes: notes ?? this.notes,
      vectorPlasmidId: vectorPlasmidId ?? this.vectorPlasmidId,
      insertPlasmidId: insertPlasmidId ?? this.insertPlasmidId,
      destinationPlasmidId: destinationPlasmidId ?? this.destinationPlasmidId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (experimentRecordId.present) {
      map['experiment_record_id'] = Variable<int>(experimentRecordId.value);
    }
    if (cloningMethod.present) {
      map['cloning_method'] = Variable<String>(cloningMethod.value);
    }
    if (enzyme1.present) {
      map['enzyme1'] = Variable<String>(enzyme1.value);
    }
    if (enzyme2.present) {
      map['enzyme2'] = Variable<String>(enzyme2.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (vectorPlasmidId.present) {
      map['vector_plasmid_id'] = Variable<int>(vectorPlasmidId.value);
    }
    if (insertPlasmidId.present) {
      map['insert_plasmid_id'] = Variable<int>(insertPlasmidId.value);
    }
    if (destinationPlasmidId.present) {
      map['destination_plasmid_id'] = Variable<int>(destinationPlasmidId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CloningDetailsCompanion(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('cloningMethod: $cloningMethod, ')
          ..write('enzyme1: $enzyme1, ')
          ..write('enzyme2: $enzyme2, ')
          ..write('notes: $notes, ')
          ..write('vectorPlasmidId: $vectorPlasmidId, ')
          ..write('insertPlasmidId: $insertPlasmidId, ')
          ..write('destinationPlasmidId: $destinationPlasmidId')
          ..write(')'))
        .toString();
  }
}

class $TransfectionDetailsTable extends TransfectionDetails
    with TableInfo<$TransfectionDetailsTable, TransfectionDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransfectionDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _experimentRecordIdMeta =
      const VerificationMeta('experimentRecordId');
  @override
  late final GeneratedColumn<int> experimentRecordId = GeneratedColumn<int>(
      'experiment_record_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cellLineMeta =
      const VerificationMeta('cellLine');
  @override
  late final GeneratedColumn<String> cellLine = GeneratedColumn<String>(
      'cell_line', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _passageNumberMeta =
      const VerificationMeta('passageNumber');
  @override
  late final GeneratedColumn<String> passageNumber = GeneratedColumn<String>(
      'passage_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transfectionReagentMeta =
      const VerificationMeta('transfectionReagent');
  @override
  late final GeneratedColumn<String> transfectionReagent =
      GeneratedColumn<String>('transfection_reagent', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nucleicAcidTypeMeta =
      const VerificationMeta('nucleicAcidType');
  @override
  late final GeneratedColumn<String> nucleicAcidType = GeneratedColumn<String>(
      'nucleic_acid_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nucleicAcidIdMeta =
      const VerificationMeta('nucleicAcidId');
  @override
  late final GeneratedColumn<String> nucleicAcidId = GeneratedColumn<String>(
      'nucleic_acid_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _plateFormatMeta =
      const VerificationMeta('plateFormat');
  @override
  late final GeneratedColumn<String> plateFormat = GeneratedColumn<String>(
      'plate_format', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _observationTimepointMeta =
      const VerificationMeta('observationTimepoint');
  @override
  late final GeneratedColumn<String> observationTimepoint =
      GeneratedColumn<String>('observation_timepoint', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transfectionEfficiencyMeta =
      const VerificationMeta('transfectionEfficiency');
  @override
  late final GeneratedColumn<String> transfectionEfficiency =
      GeneratedColumn<String>('transfection_efficiency', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _toxicityObservationMeta =
      const VerificationMeta('toxicityObservation');
  @override
  late final GeneratedColumn<String> toxicityObservation =
      GeneratedColumn<String>('toxicity_observation', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endpointResultMeta =
      const VerificationMeta('endpointResult');
  @override
  late final GeneratedColumn<String> endpointResult = GeneratedColumn<String>(
      'endpoint_result', aliasedName, true,
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
  List<GeneratedColumn> get $columns => [
        id,
        experimentRecordId,
        cellLine,
        passageNumber,
        transfectionReagent,
        nucleicAcidType,
        nucleicAcidId,
        plateFormat,
        observationTimepoint,
        transfectionEfficiency,
        toxicityObservation,
        endpointResult,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transfection_details';
  @override
  VerificationContext validateIntegrity(Insertable<TransfectionDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('experiment_record_id')) {
      context.handle(
          _experimentRecordIdMeta,
          experimentRecordId.isAcceptableOrUnknown(
              data['experiment_record_id']!, _experimentRecordIdMeta));
    } else if (isInserting) {
      context.missing(_experimentRecordIdMeta);
    }
    if (data.containsKey('cell_line')) {
      context.handle(_cellLineMeta,
          cellLine.isAcceptableOrUnknown(data['cell_line']!, _cellLineMeta));
    }
    if (data.containsKey('passage_number')) {
      context.handle(
          _passageNumberMeta,
          passageNumber.isAcceptableOrUnknown(
              data['passage_number']!, _passageNumberMeta));
    }
    if (data.containsKey('transfection_reagent')) {
      context.handle(
          _transfectionReagentMeta,
          transfectionReagent.isAcceptableOrUnknown(
              data['transfection_reagent']!, _transfectionReagentMeta));
    }
    if (data.containsKey('nucleic_acid_type')) {
      context.handle(
          _nucleicAcidTypeMeta,
          nucleicAcidType.isAcceptableOrUnknown(
              data['nucleic_acid_type']!, _nucleicAcidTypeMeta));
    }
    if (data.containsKey('nucleic_acid_id')) {
      context.handle(
          _nucleicAcidIdMeta,
          nucleicAcidId.isAcceptableOrUnknown(
              data['nucleic_acid_id']!, _nucleicAcidIdMeta));
    }
    if (data.containsKey('plate_format')) {
      context.handle(
          _plateFormatMeta,
          plateFormat.isAcceptableOrUnknown(
              data['plate_format']!, _plateFormatMeta));
    }
    if (data.containsKey('observation_timepoint')) {
      context.handle(
          _observationTimepointMeta,
          observationTimepoint.isAcceptableOrUnknown(
              data['observation_timepoint']!, _observationTimepointMeta));
    }
    if (data.containsKey('transfection_efficiency')) {
      context.handle(
          _transfectionEfficiencyMeta,
          transfectionEfficiency.isAcceptableOrUnknown(
              data['transfection_efficiency']!, _transfectionEfficiencyMeta));
    }
    if (data.containsKey('toxicity_observation')) {
      context.handle(
          _toxicityObservationMeta,
          toxicityObservation.isAcceptableOrUnknown(
              data['toxicity_observation']!, _toxicityObservationMeta));
    }
    if (data.containsKey('endpoint_result')) {
      context.handle(
          _endpointResultMeta,
          endpointResult.isAcceptableOrUnknown(
              data['endpoint_result']!, _endpointResultMeta));
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
  TransfectionDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransfectionDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      experimentRecordId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}experiment_record_id'])!,
      cellLine: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cell_line']),
      passageNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}passage_number']),
      transfectionReagent: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transfection_reagent']),
      nucleicAcidType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nucleic_acid_type']),
      nucleicAcidId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nucleic_acid_id']),
      plateFormat: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plate_format']),
      observationTimepoint: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}observation_timepoint']),
      transfectionEfficiency: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}transfection_efficiency']),
      toxicityObservation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}toxicity_observation']),
      endpointResult: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endpoint_result']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TransfectionDetailsTable createAlias(String alias) {
    return $TransfectionDetailsTable(attachedDatabase, alias);
  }
}

class TransfectionDetail extends DataClass
    implements Insertable<TransfectionDetail> {
  final int id;
  final int experimentRecordId;
  final String? cellLine;
  final String? passageNumber;
  final String? transfectionReagent;
  final String? nucleicAcidType;
  final String? nucleicAcidId;
  final String? plateFormat;
  final String? observationTimepoint;
  final String? transfectionEfficiency;
  final String? toxicityObservation;
  final String? endpointResult;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TransfectionDetail(
      {required this.id,
      required this.experimentRecordId,
      this.cellLine,
      this.passageNumber,
      this.transfectionReagent,
      this.nucleicAcidType,
      this.nucleicAcidId,
      this.plateFormat,
      this.observationTimepoint,
      this.transfectionEfficiency,
      this.toxicityObservation,
      this.endpointResult,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['experiment_record_id'] = Variable<int>(experimentRecordId);
    if (!nullToAbsent || cellLine != null) {
      map['cell_line'] = Variable<String>(cellLine);
    }
    if (!nullToAbsent || passageNumber != null) {
      map['passage_number'] = Variable<String>(passageNumber);
    }
    if (!nullToAbsent || transfectionReagent != null) {
      map['transfection_reagent'] = Variable<String>(transfectionReagent);
    }
    if (!nullToAbsent || nucleicAcidType != null) {
      map['nucleic_acid_type'] = Variable<String>(nucleicAcidType);
    }
    if (!nullToAbsent || nucleicAcidId != null) {
      map['nucleic_acid_id'] = Variable<String>(nucleicAcidId);
    }
    if (!nullToAbsent || plateFormat != null) {
      map['plate_format'] = Variable<String>(plateFormat);
    }
    if (!nullToAbsent || observationTimepoint != null) {
      map['observation_timepoint'] = Variable<String>(observationTimepoint);
    }
    if (!nullToAbsent || transfectionEfficiency != null) {
      map['transfection_efficiency'] = Variable<String>(transfectionEfficiency);
    }
    if (!nullToAbsent || toxicityObservation != null) {
      map['toxicity_observation'] = Variable<String>(toxicityObservation);
    }
    if (!nullToAbsent || endpointResult != null) {
      map['endpoint_result'] = Variable<String>(endpointResult);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransfectionDetailsCompanion toCompanion(bool nullToAbsent) {
    return TransfectionDetailsCompanion(
      id: Value(id),
      experimentRecordId: Value(experimentRecordId),
      cellLine: cellLine == null && nullToAbsent
          ? const Value.absent()
          : Value(cellLine),
      passageNumber: passageNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(passageNumber),
      transfectionReagent: transfectionReagent == null && nullToAbsent
          ? const Value.absent()
          : Value(transfectionReagent),
      nucleicAcidType: nucleicAcidType == null && nullToAbsent
          ? const Value.absent()
          : Value(nucleicAcidType),
      nucleicAcidId: nucleicAcidId == null && nullToAbsent
          ? const Value.absent()
          : Value(nucleicAcidId),
      plateFormat: plateFormat == null && nullToAbsent
          ? const Value.absent()
          : Value(plateFormat),
      observationTimepoint: observationTimepoint == null && nullToAbsent
          ? const Value.absent()
          : Value(observationTimepoint),
      transfectionEfficiency: transfectionEfficiency == null && nullToAbsent
          ? const Value.absent()
          : Value(transfectionEfficiency),
      toxicityObservation: toxicityObservation == null && nullToAbsent
          ? const Value.absent()
          : Value(toxicityObservation),
      endpointResult: endpointResult == null && nullToAbsent
          ? const Value.absent()
          : Value(endpointResult),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransfectionDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransfectionDetail(
      id: serializer.fromJson<int>(json['id']),
      experimentRecordId: serializer.fromJson<int>(json['experimentRecordId']),
      cellLine: serializer.fromJson<String?>(json['cellLine']),
      passageNumber: serializer.fromJson<String?>(json['passageNumber']),
      transfectionReagent:
          serializer.fromJson<String?>(json['transfectionReagent']),
      nucleicAcidType: serializer.fromJson<String?>(json['nucleicAcidType']),
      nucleicAcidId: serializer.fromJson<String?>(json['nucleicAcidId']),
      plateFormat: serializer.fromJson<String?>(json['plateFormat']),
      observationTimepoint:
          serializer.fromJson<String?>(json['observationTimepoint']),
      transfectionEfficiency:
          serializer.fromJson<String?>(json['transfectionEfficiency']),
      toxicityObservation:
          serializer.fromJson<String?>(json['toxicityObservation']),
      endpointResult: serializer.fromJson<String?>(json['endpointResult']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'experimentRecordId': serializer.toJson<int>(experimentRecordId),
      'cellLine': serializer.toJson<String?>(cellLine),
      'passageNumber': serializer.toJson<String?>(passageNumber),
      'transfectionReagent': serializer.toJson<String?>(transfectionReagent),
      'nucleicAcidType': serializer.toJson<String?>(nucleicAcidType),
      'nucleicAcidId': serializer.toJson<String?>(nucleicAcidId),
      'plateFormat': serializer.toJson<String?>(plateFormat),
      'observationTimepoint': serializer.toJson<String?>(observationTimepoint),
      'transfectionEfficiency':
          serializer.toJson<String?>(transfectionEfficiency),
      'toxicityObservation': serializer.toJson<String?>(toxicityObservation),
      'endpointResult': serializer.toJson<String?>(endpointResult),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransfectionDetail copyWith(
          {int? id,
          int? experimentRecordId,
          Value<String?> cellLine = const Value.absent(),
          Value<String?> passageNumber = const Value.absent(),
          Value<String?> transfectionReagent = const Value.absent(),
          Value<String?> nucleicAcidType = const Value.absent(),
          Value<String?> nucleicAcidId = const Value.absent(),
          Value<String?> plateFormat = const Value.absent(),
          Value<String?> observationTimepoint = const Value.absent(),
          Value<String?> transfectionEfficiency = const Value.absent(),
          Value<String?> toxicityObservation = const Value.absent(),
          Value<String?> endpointResult = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TransfectionDetail(
        id: id ?? this.id,
        experimentRecordId: experimentRecordId ?? this.experimentRecordId,
        cellLine: cellLine.present ? cellLine.value : this.cellLine,
        passageNumber:
            passageNumber.present ? passageNumber.value : this.passageNumber,
        transfectionReagent: transfectionReagent.present
            ? transfectionReagent.value
            : this.transfectionReagent,
        nucleicAcidType: nucleicAcidType.present
            ? nucleicAcidType.value
            : this.nucleicAcidType,
        nucleicAcidId:
            nucleicAcidId.present ? nucleicAcidId.value : this.nucleicAcidId,
        plateFormat: plateFormat.present ? plateFormat.value : this.plateFormat,
        observationTimepoint: observationTimepoint.present
            ? observationTimepoint.value
            : this.observationTimepoint,
        transfectionEfficiency: transfectionEfficiency.present
            ? transfectionEfficiency.value
            : this.transfectionEfficiency,
        toxicityObservation: toxicityObservation.present
            ? toxicityObservation.value
            : this.toxicityObservation,
        endpointResult:
            endpointResult.present ? endpointResult.value : this.endpointResult,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TransfectionDetail copyWithCompanion(TransfectionDetailsCompanion data) {
    return TransfectionDetail(
      id: data.id.present ? data.id.value : this.id,
      experimentRecordId: data.experimentRecordId.present
          ? data.experimentRecordId.value
          : this.experimentRecordId,
      cellLine: data.cellLine.present ? data.cellLine.value : this.cellLine,
      passageNumber: data.passageNumber.present
          ? data.passageNumber.value
          : this.passageNumber,
      transfectionReagent: data.transfectionReagent.present
          ? data.transfectionReagent.value
          : this.transfectionReagent,
      nucleicAcidType: data.nucleicAcidType.present
          ? data.nucleicAcidType.value
          : this.nucleicAcidType,
      nucleicAcidId: data.nucleicAcidId.present
          ? data.nucleicAcidId.value
          : this.nucleicAcidId,
      plateFormat:
          data.plateFormat.present ? data.plateFormat.value : this.plateFormat,
      observationTimepoint: data.observationTimepoint.present
          ? data.observationTimepoint.value
          : this.observationTimepoint,
      transfectionEfficiency: data.transfectionEfficiency.present
          ? data.transfectionEfficiency.value
          : this.transfectionEfficiency,
      toxicityObservation: data.toxicityObservation.present
          ? data.toxicityObservation.value
          : this.toxicityObservation,
      endpointResult: data.endpointResult.present
          ? data.endpointResult.value
          : this.endpointResult,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransfectionDetail(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('cellLine: $cellLine, ')
          ..write('passageNumber: $passageNumber, ')
          ..write('transfectionReagent: $transfectionReagent, ')
          ..write('nucleicAcidType: $nucleicAcidType, ')
          ..write('nucleicAcidId: $nucleicAcidId, ')
          ..write('plateFormat: $plateFormat, ')
          ..write('observationTimepoint: $observationTimepoint, ')
          ..write('transfectionEfficiency: $transfectionEfficiency, ')
          ..write('toxicityObservation: $toxicityObservation, ')
          ..write('endpointResult: $endpointResult, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      experimentRecordId,
      cellLine,
      passageNumber,
      transfectionReagent,
      nucleicAcidType,
      nucleicAcidId,
      plateFormat,
      observationTimepoint,
      transfectionEfficiency,
      toxicityObservation,
      endpointResult,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransfectionDetail &&
          other.id == this.id &&
          other.experimentRecordId == this.experimentRecordId &&
          other.cellLine == this.cellLine &&
          other.passageNumber == this.passageNumber &&
          other.transfectionReagent == this.transfectionReagent &&
          other.nucleicAcidType == this.nucleicAcidType &&
          other.nucleicAcidId == this.nucleicAcidId &&
          other.plateFormat == this.plateFormat &&
          other.observationTimepoint == this.observationTimepoint &&
          other.transfectionEfficiency == this.transfectionEfficiency &&
          other.toxicityObservation == this.toxicityObservation &&
          other.endpointResult == this.endpointResult &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransfectionDetailsCompanion extends UpdateCompanion<TransfectionDetail> {
  final Value<int> id;
  final Value<int> experimentRecordId;
  final Value<String?> cellLine;
  final Value<String?> passageNumber;
  final Value<String?> transfectionReagent;
  final Value<String?> nucleicAcidType;
  final Value<String?> nucleicAcidId;
  final Value<String?> plateFormat;
  final Value<String?> observationTimepoint;
  final Value<String?> transfectionEfficiency;
  final Value<String?> toxicityObservation;
  final Value<String?> endpointResult;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TransfectionDetailsCompanion({
    this.id = const Value.absent(),
    this.experimentRecordId = const Value.absent(),
    this.cellLine = const Value.absent(),
    this.passageNumber = const Value.absent(),
    this.transfectionReagent = const Value.absent(),
    this.nucleicAcidType = const Value.absent(),
    this.nucleicAcidId = const Value.absent(),
    this.plateFormat = const Value.absent(),
    this.observationTimepoint = const Value.absent(),
    this.transfectionEfficiency = const Value.absent(),
    this.toxicityObservation = const Value.absent(),
    this.endpointResult = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransfectionDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int experimentRecordId,
    this.cellLine = const Value.absent(),
    this.passageNumber = const Value.absent(),
    this.transfectionReagent = const Value.absent(),
    this.nucleicAcidType = const Value.absent(),
    this.nucleicAcidId = const Value.absent(),
    this.plateFormat = const Value.absent(),
    this.observationTimepoint = const Value.absent(),
    this.transfectionEfficiency = const Value.absent(),
    this.toxicityObservation = const Value.absent(),
    this.endpointResult = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : experimentRecordId = Value(experimentRecordId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TransfectionDetail> custom({
    Expression<int>? id,
    Expression<int>? experimentRecordId,
    Expression<String>? cellLine,
    Expression<String>? passageNumber,
    Expression<String>? transfectionReagent,
    Expression<String>? nucleicAcidType,
    Expression<String>? nucleicAcidId,
    Expression<String>? plateFormat,
    Expression<String>? observationTimepoint,
    Expression<String>? transfectionEfficiency,
    Expression<String>? toxicityObservation,
    Expression<String>? endpointResult,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (experimentRecordId != null)
        'experiment_record_id': experimentRecordId,
      if (cellLine != null) 'cell_line': cellLine,
      if (passageNumber != null) 'passage_number': passageNumber,
      if (transfectionReagent != null)
        'transfection_reagent': transfectionReagent,
      if (nucleicAcidType != null) 'nucleic_acid_type': nucleicAcidType,
      if (nucleicAcidId != null) 'nucleic_acid_id': nucleicAcidId,
      if (plateFormat != null) 'plate_format': plateFormat,
      if (observationTimepoint != null)
        'observation_timepoint': observationTimepoint,
      if (transfectionEfficiency != null)
        'transfection_efficiency': transfectionEfficiency,
      if (toxicityObservation != null)
        'toxicity_observation': toxicityObservation,
      if (endpointResult != null) 'endpoint_result': endpointResult,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TransfectionDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? experimentRecordId,
      Value<String?>? cellLine,
      Value<String?>? passageNumber,
      Value<String?>? transfectionReagent,
      Value<String?>? nucleicAcidType,
      Value<String?>? nucleicAcidId,
      Value<String?>? plateFormat,
      Value<String?>? observationTimepoint,
      Value<String?>? transfectionEfficiency,
      Value<String?>? toxicityObservation,
      Value<String?>? endpointResult,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return TransfectionDetailsCompanion(
      id: id ?? this.id,
      experimentRecordId: experimentRecordId ?? this.experimentRecordId,
      cellLine: cellLine ?? this.cellLine,
      passageNumber: passageNumber ?? this.passageNumber,
      transfectionReagent: transfectionReagent ?? this.transfectionReagent,
      nucleicAcidType: nucleicAcidType ?? this.nucleicAcidType,
      nucleicAcidId: nucleicAcidId ?? this.nucleicAcidId,
      plateFormat: plateFormat ?? this.plateFormat,
      observationTimepoint: observationTimepoint ?? this.observationTimepoint,
      transfectionEfficiency:
          transfectionEfficiency ?? this.transfectionEfficiency,
      toxicityObservation: toxicityObservation ?? this.toxicityObservation,
      endpointResult: endpointResult ?? this.endpointResult,
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
    if (experimentRecordId.present) {
      map['experiment_record_id'] = Variable<int>(experimentRecordId.value);
    }
    if (cellLine.present) {
      map['cell_line'] = Variable<String>(cellLine.value);
    }
    if (passageNumber.present) {
      map['passage_number'] = Variable<String>(passageNumber.value);
    }
    if (transfectionReagent.present) {
      map['transfection_reagent'] = Variable<String>(transfectionReagent.value);
    }
    if (nucleicAcidType.present) {
      map['nucleic_acid_type'] = Variable<String>(nucleicAcidType.value);
    }
    if (nucleicAcidId.present) {
      map['nucleic_acid_id'] = Variable<String>(nucleicAcidId.value);
    }
    if (plateFormat.present) {
      map['plate_format'] = Variable<String>(plateFormat.value);
    }
    if (observationTimepoint.present) {
      map['observation_timepoint'] =
          Variable<String>(observationTimepoint.value);
    }
    if (transfectionEfficiency.present) {
      map['transfection_efficiency'] =
          Variable<String>(transfectionEfficiency.value);
    }
    if (toxicityObservation.present) {
      map['toxicity_observation'] = Variable<String>(toxicityObservation.value);
    }
    if (endpointResult.present) {
      map['endpoint_result'] = Variable<String>(endpointResult.value);
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
    return (StringBuffer('TransfectionDetailsCompanion(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('cellLine: $cellLine, ')
          ..write('passageNumber: $passageNumber, ')
          ..write('transfectionReagent: $transfectionReagent, ')
          ..write('nucleicAcidType: $nucleicAcidType, ')
          ..write('nucleicAcidId: $nucleicAcidId, ')
          ..write('plateFormat: $plateFormat, ')
          ..write('observationTimepoint: $observationTimepoint, ')
          ..write('transfectionEfficiency: $transfectionEfficiency, ')
          ..write('toxicityObservation: $toxicityObservation, ')
          ..write('endpointResult: $endpointResult, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SirnaDetailsTable extends SirnaDetails
    with TableInfo<$SirnaDetailsTable, SirnaDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SirnaDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _experimentRecordIdMeta =
      const VerificationMeta('experimentRecordId');
  @override
  late final GeneratedColumn<int> experimentRecordId = GeneratedColumn<int>(
      'experiment_record_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetGeneMeta =
      const VerificationMeta('targetGene');
  @override
  late final GeneratedColumn<String> targetGene = GeneratedColumn<String>(
      'target_gene', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sirnaNameMeta =
      const VerificationMeta('sirnaName');
  @override
  late final GeneratedColumn<String> sirnaName = GeneratedColumn<String>(
      'sirna_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sequenceMeta =
      const VerificationMeta('sequence');
  @override
  late final GeneratedColumn<String> sequence = GeneratedColumn<String>(
      'sequence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _concentrationMeta =
      const VerificationMeta('concentration');
  @override
  late final GeneratedColumn<String> concentration = GeneratedColumn<String>(
      'concentration', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _transfectionReagentMeta =
      const VerificationMeta('transfectionReagent');
  @override
  late final GeneratedColumn<String> transfectionReagent =
      GeneratedColumn<String>('transfection_reagent', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        experimentRecordId,
        targetGene,
        sirnaName,
        sequence,
        concentration,
        transfectionReagent,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sirna_details';
  @override
  VerificationContext validateIntegrity(Insertable<SirnaDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('experiment_record_id')) {
      context.handle(
          _experimentRecordIdMeta,
          experimentRecordId.isAcceptableOrUnknown(
              data['experiment_record_id']!, _experimentRecordIdMeta));
    } else if (isInserting) {
      context.missing(_experimentRecordIdMeta);
    }
    if (data.containsKey('target_gene')) {
      context.handle(
          _targetGeneMeta,
          targetGene.isAcceptableOrUnknown(
              data['target_gene']!, _targetGeneMeta));
    }
    if (data.containsKey('sirna_name')) {
      context.handle(_sirnaNameMeta,
          sirnaName.isAcceptableOrUnknown(data['sirna_name']!, _sirnaNameMeta));
    }
    if (data.containsKey('sequence')) {
      context.handle(_sequenceMeta,
          sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta));
    }
    if (data.containsKey('concentration')) {
      context.handle(
          _concentrationMeta,
          concentration.isAcceptableOrUnknown(
              data['concentration']!, _concentrationMeta));
    }
    if (data.containsKey('transfection_reagent')) {
      context.handle(
          _transfectionReagentMeta,
          transfectionReagent.isAcceptableOrUnknown(
              data['transfection_reagent']!, _transfectionReagentMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SirnaDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SirnaDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      experimentRecordId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}experiment_record_id'])!,
      targetGene: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_gene']),
      sirnaName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sirna_name']),
      sequence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sequence']),
      concentration: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}concentration']),
      transfectionReagent: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}transfection_reagent']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $SirnaDetailsTable createAlias(String alias) {
    return $SirnaDetailsTable(attachedDatabase, alias);
  }
}

class SirnaDetail extends DataClass implements Insertable<SirnaDetail> {
  final int id;
  final int experimentRecordId;
  final String? targetGene;
  final String? sirnaName;
  final String? sequence;
  final String? concentration;
  final String? transfectionReagent;
  final String? notes;
  const SirnaDetail(
      {required this.id,
      required this.experimentRecordId,
      this.targetGene,
      this.sirnaName,
      this.sequence,
      this.concentration,
      this.transfectionReagent,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['experiment_record_id'] = Variable<int>(experimentRecordId);
    if (!nullToAbsent || targetGene != null) {
      map['target_gene'] = Variable<String>(targetGene);
    }
    if (!nullToAbsent || sirnaName != null) {
      map['sirna_name'] = Variable<String>(sirnaName);
    }
    if (!nullToAbsent || sequence != null) {
      map['sequence'] = Variable<String>(sequence);
    }
    if (!nullToAbsent || concentration != null) {
      map['concentration'] = Variable<String>(concentration);
    }
    if (!nullToAbsent || transfectionReagent != null) {
      map['transfection_reagent'] = Variable<String>(transfectionReagent);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  SirnaDetailsCompanion toCompanion(bool nullToAbsent) {
    return SirnaDetailsCompanion(
      id: Value(id),
      experimentRecordId: Value(experimentRecordId),
      targetGene: targetGene == null && nullToAbsent
          ? const Value.absent()
          : Value(targetGene),
      sirnaName: sirnaName == null && nullToAbsent
          ? const Value.absent()
          : Value(sirnaName),
      sequence: sequence == null && nullToAbsent
          ? const Value.absent()
          : Value(sequence),
      concentration: concentration == null && nullToAbsent
          ? const Value.absent()
          : Value(concentration),
      transfectionReagent: transfectionReagent == null && nullToAbsent
          ? const Value.absent()
          : Value(transfectionReagent),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory SirnaDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SirnaDetail(
      id: serializer.fromJson<int>(json['id']),
      experimentRecordId: serializer.fromJson<int>(json['experimentRecordId']),
      targetGene: serializer.fromJson<String?>(json['targetGene']),
      sirnaName: serializer.fromJson<String?>(json['sirnaName']),
      sequence: serializer.fromJson<String?>(json['sequence']),
      concentration: serializer.fromJson<String?>(json['concentration']),
      transfectionReagent:
          serializer.fromJson<String?>(json['transfectionReagent']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'experimentRecordId': serializer.toJson<int>(experimentRecordId),
      'targetGene': serializer.toJson<String?>(targetGene),
      'sirnaName': serializer.toJson<String?>(sirnaName),
      'sequence': serializer.toJson<String?>(sequence),
      'concentration': serializer.toJson<String?>(concentration),
      'transfectionReagent': serializer.toJson<String?>(transfectionReagent),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  SirnaDetail copyWith(
          {int? id,
          int? experimentRecordId,
          Value<String?> targetGene = const Value.absent(),
          Value<String?> sirnaName = const Value.absent(),
          Value<String?> sequence = const Value.absent(),
          Value<String?> concentration = const Value.absent(),
          Value<String?> transfectionReagent = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      SirnaDetail(
        id: id ?? this.id,
        experimentRecordId: experimentRecordId ?? this.experimentRecordId,
        targetGene: targetGene.present ? targetGene.value : this.targetGene,
        sirnaName: sirnaName.present ? sirnaName.value : this.sirnaName,
        sequence: sequence.present ? sequence.value : this.sequence,
        concentration:
            concentration.present ? concentration.value : this.concentration,
        transfectionReagent: transfectionReagent.present
            ? transfectionReagent.value
            : this.transfectionReagent,
        notes: notes.present ? notes.value : this.notes,
      );
  SirnaDetail copyWithCompanion(SirnaDetailsCompanion data) {
    return SirnaDetail(
      id: data.id.present ? data.id.value : this.id,
      experimentRecordId: data.experimentRecordId.present
          ? data.experimentRecordId.value
          : this.experimentRecordId,
      targetGene:
          data.targetGene.present ? data.targetGene.value : this.targetGene,
      sirnaName: data.sirnaName.present ? data.sirnaName.value : this.sirnaName,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      concentration: data.concentration.present
          ? data.concentration.value
          : this.concentration,
      transfectionReagent: data.transfectionReagent.present
          ? data.transfectionReagent.value
          : this.transfectionReagent,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SirnaDetail(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('targetGene: $targetGene, ')
          ..write('sirnaName: $sirnaName, ')
          ..write('sequence: $sequence, ')
          ..write('concentration: $concentration, ')
          ..write('transfectionReagent: $transfectionReagent, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, experimentRecordId, targetGene, sirnaName,
      sequence, concentration, transfectionReagent, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SirnaDetail &&
          other.id == this.id &&
          other.experimentRecordId == this.experimentRecordId &&
          other.targetGene == this.targetGene &&
          other.sirnaName == this.sirnaName &&
          other.sequence == this.sequence &&
          other.concentration == this.concentration &&
          other.transfectionReagent == this.transfectionReagent &&
          other.notes == this.notes);
}

class SirnaDetailsCompanion extends UpdateCompanion<SirnaDetail> {
  final Value<int> id;
  final Value<int> experimentRecordId;
  final Value<String?> targetGene;
  final Value<String?> sirnaName;
  final Value<String?> sequence;
  final Value<String?> concentration;
  final Value<String?> transfectionReagent;
  final Value<String?> notes;
  const SirnaDetailsCompanion({
    this.id = const Value.absent(),
    this.experimentRecordId = const Value.absent(),
    this.targetGene = const Value.absent(),
    this.sirnaName = const Value.absent(),
    this.sequence = const Value.absent(),
    this.concentration = const Value.absent(),
    this.transfectionReagent = const Value.absent(),
    this.notes = const Value.absent(),
  });
  SirnaDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int experimentRecordId,
    this.targetGene = const Value.absent(),
    this.sirnaName = const Value.absent(),
    this.sequence = const Value.absent(),
    this.concentration = const Value.absent(),
    this.transfectionReagent = const Value.absent(),
    this.notes = const Value.absent(),
  }) : experimentRecordId = Value(experimentRecordId);
  static Insertable<SirnaDetail> custom({
    Expression<int>? id,
    Expression<int>? experimentRecordId,
    Expression<String>? targetGene,
    Expression<String>? sirnaName,
    Expression<String>? sequence,
    Expression<String>? concentration,
    Expression<String>? transfectionReagent,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (experimentRecordId != null)
        'experiment_record_id': experimentRecordId,
      if (targetGene != null) 'target_gene': targetGene,
      if (sirnaName != null) 'sirna_name': sirnaName,
      if (sequence != null) 'sequence': sequence,
      if (concentration != null) 'concentration': concentration,
      if (transfectionReagent != null)
        'transfection_reagent': transfectionReagent,
      if (notes != null) 'notes': notes,
    });
  }

  SirnaDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? experimentRecordId,
      Value<String?>? targetGene,
      Value<String?>? sirnaName,
      Value<String?>? sequence,
      Value<String?>? concentration,
      Value<String?>? transfectionReagent,
      Value<String?>? notes}) {
    return SirnaDetailsCompanion(
      id: id ?? this.id,
      experimentRecordId: experimentRecordId ?? this.experimentRecordId,
      targetGene: targetGene ?? this.targetGene,
      sirnaName: sirnaName ?? this.sirnaName,
      sequence: sequence ?? this.sequence,
      concentration: concentration ?? this.concentration,
      transfectionReagent: transfectionReagent ?? this.transfectionReagent,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (experimentRecordId.present) {
      map['experiment_record_id'] = Variable<int>(experimentRecordId.value);
    }
    if (targetGene.present) {
      map['target_gene'] = Variable<String>(targetGene.value);
    }
    if (sirnaName.present) {
      map['sirna_name'] = Variable<String>(sirnaName.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<String>(sequence.value);
    }
    if (concentration.present) {
      map['concentration'] = Variable<String>(concentration.value);
    }
    if (transfectionReagent.present) {
      map['transfection_reagent'] = Variable<String>(transfectionReagent.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SirnaDetailsCompanion(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('targetGene: $targetGene, ')
          ..write('sirnaName: $sirnaName, ')
          ..write('sequence: $sequence, ')
          ..write('concentration: $concentration, ')
          ..write('transfectionReagent: $transfectionReagent, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PurificationDetailsTable extends PurificationDetails
    with TableInfo<$PurificationDetailsTable, PurificationDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurificationDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _experimentRecordIdMeta =
      const VerificationMeta('experimentRecordId');
  @override
  late final GeneratedColumn<int> experimentRecordId = GeneratedColumn<int>(
      'experiment_record_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sampleNameMeta =
      const VerificationMeta('sampleName');
  @override
  late final GeneratedColumn<String> sampleName = GeneratedColumn<String>(
      'sample_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _purificationMethodMeta =
      const VerificationMeta('purificationMethod');
  @override
  late final GeneratedColumn<String> purificationMethod =
      GeneratedColumn<String>('purification_method', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bufferCompositionMeta =
      const VerificationMeta('bufferComposition');
  @override
  late final GeneratedColumn<String> bufferComposition =
      GeneratedColumn<String>('buffer_composition', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _elutionConditionMeta =
      const VerificationMeta('elutionCondition');
  @override
  late final GeneratedColumn<String> elutionCondition = GeneratedColumn<String>(
      'elution_condition', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _yieldAmountMeta =
      const VerificationMeta('yieldAmount');
  @override
  late final GeneratedColumn<String> yieldAmount = GeneratedColumn<String>(
      'yield_amount', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        experimentRecordId,
        sampleName,
        purificationMethod,
        bufferComposition,
        elutionCondition,
        yieldAmount,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purification_details';
  @override
  VerificationContext validateIntegrity(Insertable<PurificationDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('experiment_record_id')) {
      context.handle(
          _experimentRecordIdMeta,
          experimentRecordId.isAcceptableOrUnknown(
              data['experiment_record_id']!, _experimentRecordIdMeta));
    } else if (isInserting) {
      context.missing(_experimentRecordIdMeta);
    }
    if (data.containsKey('sample_name')) {
      context.handle(
          _sampleNameMeta,
          sampleName.isAcceptableOrUnknown(
              data['sample_name']!, _sampleNameMeta));
    }
    if (data.containsKey('purification_method')) {
      context.handle(
          _purificationMethodMeta,
          purificationMethod.isAcceptableOrUnknown(
              data['purification_method']!, _purificationMethodMeta));
    }
    if (data.containsKey('buffer_composition')) {
      context.handle(
          _bufferCompositionMeta,
          bufferComposition.isAcceptableOrUnknown(
              data['buffer_composition']!, _bufferCompositionMeta));
    }
    if (data.containsKey('elution_condition')) {
      context.handle(
          _elutionConditionMeta,
          elutionCondition.isAcceptableOrUnknown(
              data['elution_condition']!, _elutionConditionMeta));
    }
    if (data.containsKey('yield_amount')) {
      context.handle(
          _yieldAmountMeta,
          yieldAmount.isAcceptableOrUnknown(
              data['yield_amount']!, _yieldAmountMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurificationDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurificationDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      experimentRecordId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}experiment_record_id'])!,
      sampleName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sample_name']),
      purificationMethod: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}purification_method']),
      bufferComposition: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}buffer_composition']),
      elutionCondition: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}elution_condition']),
      yieldAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}yield_amount']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $PurificationDetailsTable createAlias(String alias) {
    return $PurificationDetailsTable(attachedDatabase, alias);
  }
}

class PurificationDetail extends DataClass
    implements Insertable<PurificationDetail> {
  final int id;
  final int experimentRecordId;
  final String? sampleName;
  final String? purificationMethod;
  final String? bufferComposition;
  final String? elutionCondition;
  final String? yieldAmount;
  final String? notes;
  const PurificationDetail(
      {required this.id,
      required this.experimentRecordId,
      this.sampleName,
      this.purificationMethod,
      this.bufferComposition,
      this.elutionCondition,
      this.yieldAmount,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['experiment_record_id'] = Variable<int>(experimentRecordId);
    if (!nullToAbsent || sampleName != null) {
      map['sample_name'] = Variable<String>(sampleName);
    }
    if (!nullToAbsent || purificationMethod != null) {
      map['purification_method'] = Variable<String>(purificationMethod);
    }
    if (!nullToAbsent || bufferComposition != null) {
      map['buffer_composition'] = Variable<String>(bufferComposition);
    }
    if (!nullToAbsent || elutionCondition != null) {
      map['elution_condition'] = Variable<String>(elutionCondition);
    }
    if (!nullToAbsent || yieldAmount != null) {
      map['yield_amount'] = Variable<String>(yieldAmount);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PurificationDetailsCompanion toCompanion(bool nullToAbsent) {
    return PurificationDetailsCompanion(
      id: Value(id),
      experimentRecordId: Value(experimentRecordId),
      sampleName: sampleName == null && nullToAbsent
          ? const Value.absent()
          : Value(sampleName),
      purificationMethod: purificationMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(purificationMethod),
      bufferComposition: bufferComposition == null && nullToAbsent
          ? const Value.absent()
          : Value(bufferComposition),
      elutionCondition: elutionCondition == null && nullToAbsent
          ? const Value.absent()
          : Value(elutionCondition),
      yieldAmount: yieldAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(yieldAmount),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory PurificationDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurificationDetail(
      id: serializer.fromJson<int>(json['id']),
      experimentRecordId: serializer.fromJson<int>(json['experimentRecordId']),
      sampleName: serializer.fromJson<String?>(json['sampleName']),
      purificationMethod:
          serializer.fromJson<String?>(json['purificationMethod']),
      bufferComposition:
          serializer.fromJson<String?>(json['bufferComposition']),
      elutionCondition: serializer.fromJson<String?>(json['elutionCondition']),
      yieldAmount: serializer.fromJson<String?>(json['yieldAmount']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'experimentRecordId': serializer.toJson<int>(experimentRecordId),
      'sampleName': serializer.toJson<String?>(sampleName),
      'purificationMethod': serializer.toJson<String?>(purificationMethod),
      'bufferComposition': serializer.toJson<String?>(bufferComposition),
      'elutionCondition': serializer.toJson<String?>(elutionCondition),
      'yieldAmount': serializer.toJson<String?>(yieldAmount),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PurificationDetail copyWith(
          {int? id,
          int? experimentRecordId,
          Value<String?> sampleName = const Value.absent(),
          Value<String?> purificationMethod = const Value.absent(),
          Value<String?> bufferComposition = const Value.absent(),
          Value<String?> elutionCondition = const Value.absent(),
          Value<String?> yieldAmount = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      PurificationDetail(
        id: id ?? this.id,
        experimentRecordId: experimentRecordId ?? this.experimentRecordId,
        sampleName: sampleName.present ? sampleName.value : this.sampleName,
        purificationMethod: purificationMethod.present
            ? purificationMethod.value
            : this.purificationMethod,
        bufferComposition: bufferComposition.present
            ? bufferComposition.value
            : this.bufferComposition,
        elutionCondition: elutionCondition.present
            ? elutionCondition.value
            : this.elutionCondition,
        yieldAmount: yieldAmount.present ? yieldAmount.value : this.yieldAmount,
        notes: notes.present ? notes.value : this.notes,
      );
  PurificationDetail copyWithCompanion(PurificationDetailsCompanion data) {
    return PurificationDetail(
      id: data.id.present ? data.id.value : this.id,
      experimentRecordId: data.experimentRecordId.present
          ? data.experimentRecordId.value
          : this.experimentRecordId,
      sampleName:
          data.sampleName.present ? data.sampleName.value : this.sampleName,
      purificationMethod: data.purificationMethod.present
          ? data.purificationMethod.value
          : this.purificationMethod,
      bufferComposition: data.bufferComposition.present
          ? data.bufferComposition.value
          : this.bufferComposition,
      elutionCondition: data.elutionCondition.present
          ? data.elutionCondition.value
          : this.elutionCondition,
      yieldAmount:
          data.yieldAmount.present ? data.yieldAmount.value : this.yieldAmount,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurificationDetail(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('sampleName: $sampleName, ')
          ..write('purificationMethod: $purificationMethod, ')
          ..write('bufferComposition: $bufferComposition, ')
          ..write('elutionCondition: $elutionCondition, ')
          ..write('yieldAmount: $yieldAmount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      experimentRecordId,
      sampleName,
      purificationMethod,
      bufferComposition,
      elutionCondition,
      yieldAmount,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurificationDetail &&
          other.id == this.id &&
          other.experimentRecordId == this.experimentRecordId &&
          other.sampleName == this.sampleName &&
          other.purificationMethod == this.purificationMethod &&
          other.bufferComposition == this.bufferComposition &&
          other.elutionCondition == this.elutionCondition &&
          other.yieldAmount == this.yieldAmount &&
          other.notes == this.notes);
}

class PurificationDetailsCompanion extends UpdateCompanion<PurificationDetail> {
  final Value<int> id;
  final Value<int> experimentRecordId;
  final Value<String?> sampleName;
  final Value<String?> purificationMethod;
  final Value<String?> bufferComposition;
  final Value<String?> elutionCondition;
  final Value<String?> yieldAmount;
  final Value<String?> notes;
  const PurificationDetailsCompanion({
    this.id = const Value.absent(),
    this.experimentRecordId = const Value.absent(),
    this.sampleName = const Value.absent(),
    this.purificationMethod = const Value.absent(),
    this.bufferComposition = const Value.absent(),
    this.elutionCondition = const Value.absent(),
    this.yieldAmount = const Value.absent(),
    this.notes = const Value.absent(),
  });
  PurificationDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int experimentRecordId,
    this.sampleName = const Value.absent(),
    this.purificationMethod = const Value.absent(),
    this.bufferComposition = const Value.absent(),
    this.elutionCondition = const Value.absent(),
    this.yieldAmount = const Value.absent(),
    this.notes = const Value.absent(),
  }) : experimentRecordId = Value(experimentRecordId);
  static Insertable<PurificationDetail> custom({
    Expression<int>? id,
    Expression<int>? experimentRecordId,
    Expression<String>? sampleName,
    Expression<String>? purificationMethod,
    Expression<String>? bufferComposition,
    Expression<String>? elutionCondition,
    Expression<String>? yieldAmount,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (experimentRecordId != null)
        'experiment_record_id': experimentRecordId,
      if (sampleName != null) 'sample_name': sampleName,
      if (purificationMethod != null) 'purification_method': purificationMethod,
      if (bufferComposition != null) 'buffer_composition': bufferComposition,
      if (elutionCondition != null) 'elution_condition': elutionCondition,
      if (yieldAmount != null) 'yield_amount': yieldAmount,
      if (notes != null) 'notes': notes,
    });
  }

  PurificationDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? experimentRecordId,
      Value<String?>? sampleName,
      Value<String?>? purificationMethod,
      Value<String?>? bufferComposition,
      Value<String?>? elutionCondition,
      Value<String?>? yieldAmount,
      Value<String?>? notes}) {
    return PurificationDetailsCompanion(
      id: id ?? this.id,
      experimentRecordId: experimentRecordId ?? this.experimentRecordId,
      sampleName: sampleName ?? this.sampleName,
      purificationMethod: purificationMethod ?? this.purificationMethod,
      bufferComposition: bufferComposition ?? this.bufferComposition,
      elutionCondition: elutionCondition ?? this.elutionCondition,
      yieldAmount: yieldAmount ?? this.yieldAmount,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (experimentRecordId.present) {
      map['experiment_record_id'] = Variable<int>(experimentRecordId.value);
    }
    if (sampleName.present) {
      map['sample_name'] = Variable<String>(sampleName.value);
    }
    if (purificationMethod.present) {
      map['purification_method'] = Variable<String>(purificationMethod.value);
    }
    if (bufferComposition.present) {
      map['buffer_composition'] = Variable<String>(bufferComposition.value);
    }
    if (elutionCondition.present) {
      map['elution_condition'] = Variable<String>(elutionCondition.value);
    }
    if (yieldAmount.present) {
      map['yield_amount'] = Variable<String>(yieldAmount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurificationDetailsCompanion(')
          ..write('id: $id, ')
          ..write('experimentRecordId: $experimentRecordId, ')
          ..write('sampleName: $sampleName, ')
          ..write('purificationMethod: $purificationMethod, ')
          ..write('bufferComposition: $bufferComposition, ')
          ..write('elutionCondition: $elutionCondition, ')
          ..write('yieldAmount: $yieldAmount, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PlasmidsTable extends Plasmids with TableInfo<$PlasmidsTable, Plasmid> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlasmidsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _plasmidNameMeta =
      const VerificationMeta('plasmidName');
  @override
  late final GeneratedColumn<String> plasmidName = GeneratedColumn<String>(
      'plasmid_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _aliasMeta = const VerificationMeta('alias');
  @override
  late final GeneratedColumn<String> alias = GeneratedColumn<String>(
      'alias', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('custom'));
  static const VerificationMeta _addgeneIdMeta =
      const VerificationMeta('addgeneId');
  @override
  late final GeneratedColumn<String> addgeneId = GeneratedColumn<String>(
      'addgene_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backboneMeta =
      const VerificationMeta('backbone');
  @override
  late final GeneratedColumn<String> backbone = GeneratedColumn<String>(
      'backbone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _insertGeneMeta =
      const VerificationMeta('insertGene');
  @override
  late final GeneratedColumn<String> insertGene = GeneratedColumn<String>(
      'insert_gene', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _promoterMeta =
      const VerificationMeta('promoter');
  @override
  late final GeneratedColumn<String> promoter = GeneratedColumn<String>(
      'promoter', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bacterialAntibioticMeta =
      const VerificationMeta('bacterialAntibiotic');
  @override
  late final GeneratedColumn<String> bacterialAntibiotic =
      GeneratedColumn<String>('bacterial_antibiotic', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mammalianSelectionMeta =
      const VerificationMeta('mammalianSelection');
  @override
  late final GeneratedColumn<String> mammalianSelection =
      GeneratedColumn<String>('mammalian_selection', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _oriMeta = const VerificationMeta('ori');
  @override
  late final GeneratedColumn<String> ori = GeneratedColumn<String>(
      'ori', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeBpMeta = const VerificationMeta('sizeBp');
  @override
  late final GeneratedColumn<int> sizeBp = GeneratedColumn<int>(
      'size_bp', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genbankUrlMeta =
      const VerificationMeta('genbankUrl');
  @override
  late final GeneratedColumn<String> genbankUrl = GeneratedColumn<String>(
      'genbank_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _snapgeneUrlMeta =
      const VerificationMeta('snapgeneUrl');
  @override
  late final GeneratedColumn<String> snapgeneUrl = GeneratedColumn<String>(
      'snapgene_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCloningSelectableMeta =
      const VerificationMeta('isCloningSelectable');
  @override
  late final GeneratedColumn<bool> isCloningSelectable = GeneratedColumn<bool>(
      'is_cloning_selectable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_cloning_selectable" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        plasmidName,
        alias,
        sourceType,
        addgeneId,
        backbone,
        insertGene,
        promoter,
        tag,
        bacterialAntibiotic,
        mammalianSelection,
        ori,
        sizeBp,
        genbankUrl,
        snapgeneUrl,
        notes,
        isCloningSelectable,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plasmids';
  @override
  VerificationContext validateIntegrity(Insertable<Plasmid> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plasmid_name')) {
      context.handle(
          _plasmidNameMeta,
          plasmidName.isAcceptableOrUnknown(
              data['plasmid_name']!, _plasmidNameMeta));
    } else if (isInserting) {
      context.missing(_plasmidNameMeta);
    }
    if (data.containsKey('alias')) {
      context.handle(
          _aliasMeta, alias.isAcceptableOrUnknown(data['alias']!, _aliasMeta));
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    }
    if (data.containsKey('addgene_id')) {
      context.handle(_addgeneIdMeta,
          addgeneId.isAcceptableOrUnknown(data['addgene_id']!, _addgeneIdMeta));
    }
    if (data.containsKey('backbone')) {
      context.handle(_backboneMeta,
          backbone.isAcceptableOrUnknown(data['backbone']!, _backboneMeta));
    }
    if (data.containsKey('insert_gene')) {
      context.handle(
          _insertGeneMeta,
          insertGene.isAcceptableOrUnknown(
              data['insert_gene']!, _insertGeneMeta));
    }
    if (data.containsKey('promoter')) {
      context.handle(_promoterMeta,
          promoter.isAcceptableOrUnknown(data['promoter']!, _promoterMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    }
    if (data.containsKey('bacterial_antibiotic')) {
      context.handle(
          _bacterialAntibioticMeta,
          bacterialAntibiotic.isAcceptableOrUnknown(
              data['bacterial_antibiotic']!, _bacterialAntibioticMeta));
    }
    if (data.containsKey('mammalian_selection')) {
      context.handle(
          _mammalianSelectionMeta,
          mammalianSelection.isAcceptableOrUnknown(
              data['mammalian_selection']!, _mammalianSelectionMeta));
    }
    if (data.containsKey('ori')) {
      context.handle(
          _oriMeta, ori.isAcceptableOrUnknown(data['ori']!, _oriMeta));
    }
    if (data.containsKey('size_bp')) {
      context.handle(_sizeBpMeta,
          sizeBp.isAcceptableOrUnknown(data['size_bp']!, _sizeBpMeta));
    }
    if (data.containsKey('genbank_url')) {
      context.handle(
          _genbankUrlMeta,
          genbankUrl.isAcceptableOrUnknown(
              data['genbank_url']!, _genbankUrlMeta));
    }
    if (data.containsKey('snapgene_url')) {
      context.handle(
          _snapgeneUrlMeta,
          snapgeneUrl.isAcceptableOrUnknown(
              data['snapgene_url']!, _snapgeneUrlMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_cloning_selectable')) {
      context.handle(
          _isCloningSelectableMeta,
          isCloningSelectable.isAcceptableOrUnknown(
              data['is_cloning_selectable']!, _isCloningSelectableMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plasmid map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plasmid(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      plasmidName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plasmid_name'])!,
      alias: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alias']),
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      addgeneId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}addgene_id']),
      backbone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backbone']),
      insertGene: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}insert_gene']),
      promoter: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}promoter']),
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag']),
      bacterialAntibiotic: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}bacterial_antibiotic']),
      mammalianSelection: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}mammalian_selection']),
      ori: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ori']),
      sizeBp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bp']),
      genbankUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genbank_url']),
      snapgeneUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}snapgene_url']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isCloningSelectable: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_cloning_selectable'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PlasmidsTable createAlias(String alias) {
    return $PlasmidsTable(attachedDatabase, alias);
  }
}

class Plasmid extends DataClass implements Insertable<Plasmid> {
  final int id;
  final String plasmidName;
  final String? alias;
  final String sourceType;
  final String? addgeneId;
  final String? backbone;
  final String? insertGene;
  final String? promoter;
  final String? tag;
  final String? bacterialAntibiotic;
  final String? mammalianSelection;
  final String? ori;
  final int? sizeBp;
  final String? genbankUrl;
  final String? snapgeneUrl;
  final String? notes;
  final bool isCloningSelectable;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Plasmid(
      {required this.id,
      required this.plasmidName,
      this.alias,
      required this.sourceType,
      this.addgeneId,
      this.backbone,
      this.insertGene,
      this.promoter,
      this.tag,
      this.bacterialAntibiotic,
      this.mammalianSelection,
      this.ori,
      this.sizeBp,
      this.genbankUrl,
      this.snapgeneUrl,
      this.notes,
      required this.isCloningSelectable,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plasmid_name'] = Variable<String>(plasmidName);
    if (!nullToAbsent || alias != null) {
      map['alias'] = Variable<String>(alias);
    }
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || addgeneId != null) {
      map['addgene_id'] = Variable<String>(addgeneId);
    }
    if (!nullToAbsent || backbone != null) {
      map['backbone'] = Variable<String>(backbone);
    }
    if (!nullToAbsent || insertGene != null) {
      map['insert_gene'] = Variable<String>(insertGene);
    }
    if (!nullToAbsent || promoter != null) {
      map['promoter'] = Variable<String>(promoter);
    }
    if (!nullToAbsent || tag != null) {
      map['tag'] = Variable<String>(tag);
    }
    if (!nullToAbsent || bacterialAntibiotic != null) {
      map['bacterial_antibiotic'] = Variable<String>(bacterialAntibiotic);
    }
    if (!nullToAbsent || mammalianSelection != null) {
      map['mammalian_selection'] = Variable<String>(mammalianSelection);
    }
    if (!nullToAbsent || ori != null) {
      map['ori'] = Variable<String>(ori);
    }
    if (!nullToAbsent || sizeBp != null) {
      map['size_bp'] = Variable<int>(sizeBp);
    }
    if (!nullToAbsent || genbankUrl != null) {
      map['genbank_url'] = Variable<String>(genbankUrl);
    }
    if (!nullToAbsent || snapgeneUrl != null) {
      map['snapgene_url'] = Variable<String>(snapgeneUrl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_cloning_selectable'] = Variable<bool>(isCloningSelectable);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlasmidsCompanion toCompanion(bool nullToAbsent) {
    return PlasmidsCompanion(
      id: Value(id),
      plasmidName: Value(plasmidName),
      alias:
          alias == null && nullToAbsent ? const Value.absent() : Value(alias),
      sourceType: Value(sourceType),
      addgeneId: addgeneId == null && nullToAbsent
          ? const Value.absent()
          : Value(addgeneId),
      backbone: backbone == null && nullToAbsent
          ? const Value.absent()
          : Value(backbone),
      insertGene: insertGene == null && nullToAbsent
          ? const Value.absent()
          : Value(insertGene),
      promoter: promoter == null && nullToAbsent
          ? const Value.absent()
          : Value(promoter),
      tag: tag == null && nullToAbsent ? const Value.absent() : Value(tag),
      bacterialAntibiotic: bacterialAntibiotic == null && nullToAbsent
          ? const Value.absent()
          : Value(bacterialAntibiotic),
      mammalianSelection: mammalianSelection == null && nullToAbsent
          ? const Value.absent()
          : Value(mammalianSelection),
      ori: ori == null && nullToAbsent ? const Value.absent() : Value(ori),
      sizeBp:
          sizeBp == null && nullToAbsent ? const Value.absent() : Value(sizeBp),
      genbankUrl: genbankUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(genbankUrl),
      snapgeneUrl: snapgeneUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(snapgeneUrl),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isCloningSelectable: Value(isCloningSelectable),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Plasmid.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plasmid(
      id: serializer.fromJson<int>(json['id']),
      plasmidName: serializer.fromJson<String>(json['plasmidName']),
      alias: serializer.fromJson<String?>(json['alias']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      addgeneId: serializer.fromJson<String?>(json['addgeneId']),
      backbone: serializer.fromJson<String?>(json['backbone']),
      insertGene: serializer.fromJson<String?>(json['insertGene']),
      promoter: serializer.fromJson<String?>(json['promoter']),
      tag: serializer.fromJson<String?>(json['tag']),
      bacterialAntibiotic:
          serializer.fromJson<String?>(json['bacterialAntibiotic']),
      mammalianSelection:
          serializer.fromJson<String?>(json['mammalianSelection']),
      ori: serializer.fromJson<String?>(json['ori']),
      sizeBp: serializer.fromJson<int?>(json['sizeBp']),
      genbankUrl: serializer.fromJson<String?>(json['genbankUrl']),
      snapgeneUrl: serializer.fromJson<String?>(json['snapgeneUrl']),
      notes: serializer.fromJson<String?>(json['notes']),
      isCloningSelectable:
          serializer.fromJson<bool>(json['isCloningSelectable']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'plasmidName': serializer.toJson<String>(plasmidName),
      'alias': serializer.toJson<String?>(alias),
      'sourceType': serializer.toJson<String>(sourceType),
      'addgeneId': serializer.toJson<String?>(addgeneId),
      'backbone': serializer.toJson<String?>(backbone),
      'insertGene': serializer.toJson<String?>(insertGene),
      'promoter': serializer.toJson<String?>(promoter),
      'tag': serializer.toJson<String?>(tag),
      'bacterialAntibiotic': serializer.toJson<String?>(bacterialAntibiotic),
      'mammalianSelection': serializer.toJson<String?>(mammalianSelection),
      'ori': serializer.toJson<String?>(ori),
      'sizeBp': serializer.toJson<int?>(sizeBp),
      'genbankUrl': serializer.toJson<String?>(genbankUrl),
      'snapgeneUrl': serializer.toJson<String?>(snapgeneUrl),
      'notes': serializer.toJson<String?>(notes),
      'isCloningSelectable': serializer.toJson<bool>(isCloningSelectable),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Plasmid copyWith(
          {int? id,
          String? plasmidName,
          Value<String?> alias = const Value.absent(),
          String? sourceType,
          Value<String?> addgeneId = const Value.absent(),
          Value<String?> backbone = const Value.absent(),
          Value<String?> insertGene = const Value.absent(),
          Value<String?> promoter = const Value.absent(),
          Value<String?> tag = const Value.absent(),
          Value<String?> bacterialAntibiotic = const Value.absent(),
          Value<String?> mammalianSelection = const Value.absent(),
          Value<String?> ori = const Value.absent(),
          Value<int?> sizeBp = const Value.absent(),
          Value<String?> genbankUrl = const Value.absent(),
          Value<String?> snapgeneUrl = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? isCloningSelectable,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Plasmid(
        id: id ?? this.id,
        plasmidName: plasmidName ?? this.plasmidName,
        alias: alias.present ? alias.value : this.alias,
        sourceType: sourceType ?? this.sourceType,
        addgeneId: addgeneId.present ? addgeneId.value : this.addgeneId,
        backbone: backbone.present ? backbone.value : this.backbone,
        insertGene: insertGene.present ? insertGene.value : this.insertGene,
        promoter: promoter.present ? promoter.value : this.promoter,
        tag: tag.present ? tag.value : this.tag,
        bacterialAntibiotic: bacterialAntibiotic.present
            ? bacterialAntibiotic.value
            : this.bacterialAntibiotic,
        mammalianSelection: mammalianSelection.present
            ? mammalianSelection.value
            : this.mammalianSelection,
        ori: ori.present ? ori.value : this.ori,
        sizeBp: sizeBp.present ? sizeBp.value : this.sizeBp,
        genbankUrl: genbankUrl.present ? genbankUrl.value : this.genbankUrl,
        snapgeneUrl: snapgeneUrl.present ? snapgeneUrl.value : this.snapgeneUrl,
        notes: notes.present ? notes.value : this.notes,
        isCloningSelectable: isCloningSelectable ?? this.isCloningSelectable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Plasmid copyWithCompanion(PlasmidsCompanion data) {
    return Plasmid(
      id: data.id.present ? data.id.value : this.id,
      plasmidName:
          data.plasmidName.present ? data.plasmidName.value : this.plasmidName,
      alias: data.alias.present ? data.alias.value : this.alias,
      sourceType:
          data.sourceType.present ? data.sourceType.value : this.sourceType,
      addgeneId: data.addgeneId.present ? data.addgeneId.value : this.addgeneId,
      backbone: data.backbone.present ? data.backbone.value : this.backbone,
      insertGene:
          data.insertGene.present ? data.insertGene.value : this.insertGene,
      promoter: data.promoter.present ? data.promoter.value : this.promoter,
      tag: data.tag.present ? data.tag.value : this.tag,
      bacterialAntibiotic: data.bacterialAntibiotic.present
          ? data.bacterialAntibiotic.value
          : this.bacterialAntibiotic,
      mammalianSelection: data.mammalianSelection.present
          ? data.mammalianSelection.value
          : this.mammalianSelection,
      ori: data.ori.present ? data.ori.value : this.ori,
      sizeBp: data.sizeBp.present ? data.sizeBp.value : this.sizeBp,
      genbankUrl:
          data.genbankUrl.present ? data.genbankUrl.value : this.genbankUrl,
      snapgeneUrl:
          data.snapgeneUrl.present ? data.snapgeneUrl.value : this.snapgeneUrl,
      notes: data.notes.present ? data.notes.value : this.notes,
      isCloningSelectable: data.isCloningSelectable.present
          ? data.isCloningSelectable.value
          : this.isCloningSelectable,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plasmid(')
          ..write('id: $id, ')
          ..write('plasmidName: $plasmidName, ')
          ..write('alias: $alias, ')
          ..write('sourceType: $sourceType, ')
          ..write('addgeneId: $addgeneId, ')
          ..write('backbone: $backbone, ')
          ..write('insertGene: $insertGene, ')
          ..write('promoter: $promoter, ')
          ..write('tag: $tag, ')
          ..write('bacterialAntibiotic: $bacterialAntibiotic, ')
          ..write('mammalianSelection: $mammalianSelection, ')
          ..write('ori: $ori, ')
          ..write('sizeBp: $sizeBp, ')
          ..write('genbankUrl: $genbankUrl, ')
          ..write('snapgeneUrl: $snapgeneUrl, ')
          ..write('notes: $notes, ')
          ..write('isCloningSelectable: $isCloningSelectable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      plasmidName,
      alias,
      sourceType,
      addgeneId,
      backbone,
      insertGene,
      promoter,
      tag,
      bacterialAntibiotic,
      mammalianSelection,
      ori,
      sizeBp,
      genbankUrl,
      snapgeneUrl,
      notes,
      isCloningSelectable,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plasmid &&
          other.id == this.id &&
          other.plasmidName == this.plasmidName &&
          other.alias == this.alias &&
          other.sourceType == this.sourceType &&
          other.addgeneId == this.addgeneId &&
          other.backbone == this.backbone &&
          other.insertGene == this.insertGene &&
          other.promoter == this.promoter &&
          other.tag == this.tag &&
          other.bacterialAntibiotic == this.bacterialAntibiotic &&
          other.mammalianSelection == this.mammalianSelection &&
          other.ori == this.ori &&
          other.sizeBp == this.sizeBp &&
          other.genbankUrl == this.genbankUrl &&
          other.snapgeneUrl == this.snapgeneUrl &&
          other.notes == this.notes &&
          other.isCloningSelectable == this.isCloningSelectable &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlasmidsCompanion extends UpdateCompanion<Plasmid> {
  final Value<int> id;
  final Value<String> plasmidName;
  final Value<String?> alias;
  final Value<String> sourceType;
  final Value<String?> addgeneId;
  final Value<String?> backbone;
  final Value<String?> insertGene;
  final Value<String?> promoter;
  final Value<String?> tag;
  final Value<String?> bacterialAntibiotic;
  final Value<String?> mammalianSelection;
  final Value<String?> ori;
  final Value<int?> sizeBp;
  final Value<String?> genbankUrl;
  final Value<String?> snapgeneUrl;
  final Value<String?> notes;
  final Value<bool> isCloningSelectable;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PlasmidsCompanion({
    this.id = const Value.absent(),
    this.plasmidName = const Value.absent(),
    this.alias = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.addgeneId = const Value.absent(),
    this.backbone = const Value.absent(),
    this.insertGene = const Value.absent(),
    this.promoter = const Value.absent(),
    this.tag = const Value.absent(),
    this.bacterialAntibiotic = const Value.absent(),
    this.mammalianSelection = const Value.absent(),
    this.ori = const Value.absent(),
    this.sizeBp = const Value.absent(),
    this.genbankUrl = const Value.absent(),
    this.snapgeneUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCloningSelectable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PlasmidsCompanion.insert({
    this.id = const Value.absent(),
    required String plasmidName,
    this.alias = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.addgeneId = const Value.absent(),
    this.backbone = const Value.absent(),
    this.insertGene = const Value.absent(),
    this.promoter = const Value.absent(),
    this.tag = const Value.absent(),
    this.bacterialAntibiotic = const Value.absent(),
    this.mammalianSelection = const Value.absent(),
    this.ori = const Value.absent(),
    this.sizeBp = const Value.absent(),
    this.genbankUrl = const Value.absent(),
    this.snapgeneUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCloningSelectable = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : plasmidName = Value(plasmidName);
  static Insertable<Plasmid> custom({
    Expression<int>? id,
    Expression<String>? plasmidName,
    Expression<String>? alias,
    Expression<String>? sourceType,
    Expression<String>? addgeneId,
    Expression<String>? backbone,
    Expression<String>? insertGene,
    Expression<String>? promoter,
    Expression<String>? tag,
    Expression<String>? bacterialAntibiotic,
    Expression<String>? mammalianSelection,
    Expression<String>? ori,
    Expression<int>? sizeBp,
    Expression<String>? genbankUrl,
    Expression<String>? snapgeneUrl,
    Expression<String>? notes,
    Expression<bool>? isCloningSelectable,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plasmidName != null) 'plasmid_name': plasmidName,
      if (alias != null) 'alias': alias,
      if (sourceType != null) 'source_type': sourceType,
      if (addgeneId != null) 'addgene_id': addgeneId,
      if (backbone != null) 'backbone': backbone,
      if (insertGene != null) 'insert_gene': insertGene,
      if (promoter != null) 'promoter': promoter,
      if (tag != null) 'tag': tag,
      if (bacterialAntibiotic != null)
        'bacterial_antibiotic': bacterialAntibiotic,
      if (mammalianSelection != null) 'mammalian_selection': mammalianSelection,
      if (ori != null) 'ori': ori,
      if (sizeBp != null) 'size_bp': sizeBp,
      if (genbankUrl != null) 'genbank_url': genbankUrl,
      if (snapgeneUrl != null) 'snapgene_url': snapgeneUrl,
      if (notes != null) 'notes': notes,
      if (isCloningSelectable != null)
        'is_cloning_selectable': isCloningSelectable,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PlasmidsCompanion copyWith(
      {Value<int>? id,
      Value<String>? plasmidName,
      Value<String?>? alias,
      Value<String>? sourceType,
      Value<String?>? addgeneId,
      Value<String?>? backbone,
      Value<String?>? insertGene,
      Value<String?>? promoter,
      Value<String?>? tag,
      Value<String?>? bacterialAntibiotic,
      Value<String?>? mammalianSelection,
      Value<String?>? ori,
      Value<int?>? sizeBp,
      Value<String?>? genbankUrl,
      Value<String?>? snapgeneUrl,
      Value<String?>? notes,
      Value<bool>? isCloningSelectable,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PlasmidsCompanion(
      id: id ?? this.id,
      plasmidName: plasmidName ?? this.plasmidName,
      alias: alias ?? this.alias,
      sourceType: sourceType ?? this.sourceType,
      addgeneId: addgeneId ?? this.addgeneId,
      backbone: backbone ?? this.backbone,
      insertGene: insertGene ?? this.insertGene,
      promoter: promoter ?? this.promoter,
      tag: tag ?? this.tag,
      bacterialAntibiotic: bacterialAntibiotic ?? this.bacterialAntibiotic,
      mammalianSelection: mammalianSelection ?? this.mammalianSelection,
      ori: ori ?? this.ori,
      sizeBp: sizeBp ?? this.sizeBp,
      genbankUrl: genbankUrl ?? this.genbankUrl,
      snapgeneUrl: snapgeneUrl ?? this.snapgeneUrl,
      notes: notes ?? this.notes,
      isCloningSelectable: isCloningSelectable ?? this.isCloningSelectable,
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
    if (plasmidName.present) {
      map['plasmid_name'] = Variable<String>(plasmidName.value);
    }
    if (alias.present) {
      map['alias'] = Variable<String>(alias.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (addgeneId.present) {
      map['addgene_id'] = Variable<String>(addgeneId.value);
    }
    if (backbone.present) {
      map['backbone'] = Variable<String>(backbone.value);
    }
    if (insertGene.present) {
      map['insert_gene'] = Variable<String>(insertGene.value);
    }
    if (promoter.present) {
      map['promoter'] = Variable<String>(promoter.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (bacterialAntibiotic.present) {
      map['bacterial_antibiotic'] = Variable<String>(bacterialAntibiotic.value);
    }
    if (mammalianSelection.present) {
      map['mammalian_selection'] = Variable<String>(mammalianSelection.value);
    }
    if (ori.present) {
      map['ori'] = Variable<String>(ori.value);
    }
    if (sizeBp.present) {
      map['size_bp'] = Variable<int>(sizeBp.value);
    }
    if (genbankUrl.present) {
      map['genbank_url'] = Variable<String>(genbankUrl.value);
    }
    if (snapgeneUrl.present) {
      map['snapgene_url'] = Variable<String>(snapgeneUrl.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isCloningSelectable.present) {
      map['is_cloning_selectable'] = Variable<bool>(isCloningSelectable.value);
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
    return (StringBuffer('PlasmidsCompanion(')
          ..write('id: $id, ')
          ..write('plasmidName: $plasmidName, ')
          ..write('alias: $alias, ')
          ..write('sourceType: $sourceType, ')
          ..write('addgeneId: $addgeneId, ')
          ..write('backbone: $backbone, ')
          ..write('insertGene: $insertGene, ')
          ..write('promoter: $promoter, ')
          ..write('tag: $tag, ')
          ..write('bacterialAntibiotic: $bacterialAntibiotic, ')
          ..write('mammalianSelection: $mammalianSelection, ')
          ..write('ori: $ori, ')
          ..write('sizeBp: $sizeBp, ')
          ..write('genbankUrl: $genbankUrl, ')
          ..write('snapgeneUrl: $snapgeneUrl, ')
          ..write('notes: $notes, ')
          ..write('isCloningSelectable: $isCloningSelectable, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CellLinesTable extends CellLines
    with TableInfo<$CellLinesTable, CellLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CellLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cellLineNameMeta =
      const VerificationMeta('cellLineName');
  @override
  late final GeneratedColumn<String> cellLineName = GeneratedColumn<String>(
      'cell_line_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tissueMeta = const VerificationMeta('tissue');
  @override
  late final GeneratedColumn<String> tissue = GeneratedColumn<String>(
      'tissue', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genotypeMeta =
      const VerificationMeta('genotype');
  @override
  late final GeneratedColumn<String> genotype = GeneratedColumn<String>(
      'genotype', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cultureMediumMeta =
      const VerificationMeta('cultureMedium');
  @override
  late final GeneratedColumn<String> cultureMedium = GeneratedColumn<String>(
      'culture_medium', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _antibioticSelectionMeta =
      const VerificationMeta('antibioticSelection');
  @override
  late final GeneratedColumn<String> antibioticSelection =
      GeneratedColumn<String>('antibiotic_selection', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _storageLocationMeta =
      const VerificationMeta('storageLocation');
  @override
  late final GeneratedColumn<String> storageLocation = GeneratedColumn<String>(
      'storage_location', aliasedName, true,
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
  List<GeneratedColumn> get $columns => [
        id,
        cellLineName,
        species,
        tissue,
        genotype,
        cultureMedium,
        antibioticSelection,
        storageLocation,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cell_lines';
  @override
  VerificationContext validateIntegrity(Insertable<CellLine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cell_line_name')) {
      context.handle(
          _cellLineNameMeta,
          cellLineName.isAcceptableOrUnknown(
              data['cell_line_name']!, _cellLineNameMeta));
    } else if (isInserting) {
      context.missing(_cellLineNameMeta);
    }
    if (data.containsKey('species')) {
      context.handle(_speciesMeta,
          species.isAcceptableOrUnknown(data['species']!, _speciesMeta));
    }
    if (data.containsKey('tissue')) {
      context.handle(_tissueMeta,
          tissue.isAcceptableOrUnknown(data['tissue']!, _tissueMeta));
    }
    if (data.containsKey('genotype')) {
      context.handle(_genotypeMeta,
          genotype.isAcceptableOrUnknown(data['genotype']!, _genotypeMeta));
    }
    if (data.containsKey('culture_medium')) {
      context.handle(
          _cultureMediumMeta,
          cultureMedium.isAcceptableOrUnknown(
              data['culture_medium']!, _cultureMediumMeta));
    }
    if (data.containsKey('antibiotic_selection')) {
      context.handle(
          _antibioticSelectionMeta,
          antibioticSelection.isAcceptableOrUnknown(
              data['antibiotic_selection']!, _antibioticSelectionMeta));
    }
    if (data.containsKey('storage_location')) {
      context.handle(
          _storageLocationMeta,
          storageLocation.isAcceptableOrUnknown(
              data['storage_location']!, _storageLocationMeta));
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
  CellLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CellLine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cellLineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cell_line_name'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species']),
      tissue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tissue']),
      genotype: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genotype']),
      cultureMedium: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}culture_medium']),
      antibioticSelection: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}antibiotic_selection']),
      storageLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}storage_location']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CellLinesTable createAlias(String alias) {
    return $CellLinesTable(attachedDatabase, alias);
  }
}

class CellLine extends DataClass implements Insertable<CellLine> {
  final int id;
  final String cellLineName;
  final String? species;
  final String? tissue;
  final String? genotype;
  final String? cultureMedium;
  final String? antibioticSelection;
  final String? storageLocation;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CellLine(
      {required this.id,
      required this.cellLineName,
      this.species,
      this.tissue,
      this.genotype,
      this.cultureMedium,
      this.antibioticSelection,
      this.storageLocation,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cell_line_name'] = Variable<String>(cellLineName);
    if (!nullToAbsent || species != null) {
      map['species'] = Variable<String>(species);
    }
    if (!nullToAbsent || tissue != null) {
      map['tissue'] = Variable<String>(tissue);
    }
    if (!nullToAbsent || genotype != null) {
      map['genotype'] = Variable<String>(genotype);
    }
    if (!nullToAbsent || cultureMedium != null) {
      map['culture_medium'] = Variable<String>(cultureMedium);
    }
    if (!nullToAbsent || antibioticSelection != null) {
      map['antibiotic_selection'] = Variable<String>(antibioticSelection);
    }
    if (!nullToAbsent || storageLocation != null) {
      map['storage_location'] = Variable<String>(storageLocation);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CellLinesCompanion toCompanion(bool nullToAbsent) {
    return CellLinesCompanion(
      id: Value(id),
      cellLineName: Value(cellLineName),
      species: species == null && nullToAbsent
          ? const Value.absent()
          : Value(species),
      tissue:
          tissue == null && nullToAbsent ? const Value.absent() : Value(tissue),
      genotype: genotype == null && nullToAbsent
          ? const Value.absent()
          : Value(genotype),
      cultureMedium: cultureMedium == null && nullToAbsent
          ? const Value.absent()
          : Value(cultureMedium),
      antibioticSelection: antibioticSelection == null && nullToAbsent
          ? const Value.absent()
          : Value(antibioticSelection),
      storageLocation: storageLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(storageLocation),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CellLine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CellLine(
      id: serializer.fromJson<int>(json['id']),
      cellLineName: serializer.fromJson<String>(json['cellLineName']),
      species: serializer.fromJson<String?>(json['species']),
      tissue: serializer.fromJson<String?>(json['tissue']),
      genotype: serializer.fromJson<String?>(json['genotype']),
      cultureMedium: serializer.fromJson<String?>(json['cultureMedium']),
      antibioticSelection:
          serializer.fromJson<String?>(json['antibioticSelection']),
      storageLocation: serializer.fromJson<String?>(json['storageLocation']),
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
      'cellLineName': serializer.toJson<String>(cellLineName),
      'species': serializer.toJson<String?>(species),
      'tissue': serializer.toJson<String?>(tissue),
      'genotype': serializer.toJson<String?>(genotype),
      'cultureMedium': serializer.toJson<String?>(cultureMedium),
      'antibioticSelection': serializer.toJson<String?>(antibioticSelection),
      'storageLocation': serializer.toJson<String?>(storageLocation),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CellLine copyWith(
          {int? id,
          String? cellLineName,
          Value<String?> species = const Value.absent(),
          Value<String?> tissue = const Value.absent(),
          Value<String?> genotype = const Value.absent(),
          Value<String?> cultureMedium = const Value.absent(),
          Value<String?> antibioticSelection = const Value.absent(),
          Value<String?> storageLocation = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CellLine(
        id: id ?? this.id,
        cellLineName: cellLineName ?? this.cellLineName,
        species: species.present ? species.value : this.species,
        tissue: tissue.present ? tissue.value : this.tissue,
        genotype: genotype.present ? genotype.value : this.genotype,
        cultureMedium:
            cultureMedium.present ? cultureMedium.value : this.cultureMedium,
        antibioticSelection: antibioticSelection.present
            ? antibioticSelection.value
            : this.antibioticSelection,
        storageLocation: storageLocation.present
            ? storageLocation.value
            : this.storageLocation,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CellLine copyWithCompanion(CellLinesCompanion data) {
    return CellLine(
      id: data.id.present ? data.id.value : this.id,
      cellLineName: data.cellLineName.present
          ? data.cellLineName.value
          : this.cellLineName,
      species: data.species.present ? data.species.value : this.species,
      tissue: data.tissue.present ? data.tissue.value : this.tissue,
      genotype: data.genotype.present ? data.genotype.value : this.genotype,
      cultureMedium: data.cultureMedium.present
          ? data.cultureMedium.value
          : this.cultureMedium,
      antibioticSelection: data.antibioticSelection.present
          ? data.antibioticSelection.value
          : this.antibioticSelection,
      storageLocation: data.storageLocation.present
          ? data.storageLocation.value
          : this.storageLocation,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CellLine(')
          ..write('id: $id, ')
          ..write('cellLineName: $cellLineName, ')
          ..write('species: $species, ')
          ..write('tissue: $tissue, ')
          ..write('genotype: $genotype, ')
          ..write('cultureMedium: $cultureMedium, ')
          ..write('antibioticSelection: $antibioticSelection, ')
          ..write('storageLocation: $storageLocation, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      cellLineName,
      species,
      tissue,
      genotype,
      cultureMedium,
      antibioticSelection,
      storageLocation,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CellLine &&
          other.id == this.id &&
          other.cellLineName == this.cellLineName &&
          other.species == this.species &&
          other.tissue == this.tissue &&
          other.genotype == this.genotype &&
          other.cultureMedium == this.cultureMedium &&
          other.antibioticSelection == this.antibioticSelection &&
          other.storageLocation == this.storageLocation &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CellLinesCompanion extends UpdateCompanion<CellLine> {
  final Value<int> id;
  final Value<String> cellLineName;
  final Value<String?> species;
  final Value<String?> tissue;
  final Value<String?> genotype;
  final Value<String?> cultureMedium;
  final Value<String?> antibioticSelection;
  final Value<String?> storageLocation;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CellLinesCompanion({
    this.id = const Value.absent(),
    this.cellLineName = const Value.absent(),
    this.species = const Value.absent(),
    this.tissue = const Value.absent(),
    this.genotype = const Value.absent(),
    this.cultureMedium = const Value.absent(),
    this.antibioticSelection = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CellLinesCompanion.insert({
    this.id = const Value.absent(),
    required String cellLineName,
    this.species = const Value.absent(),
    this.tissue = const Value.absent(),
    this.genotype = const Value.absent(),
    this.cultureMedium = const Value.absent(),
    this.antibioticSelection = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : cellLineName = Value(cellLineName),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CellLine> custom({
    Expression<int>? id,
    Expression<String>? cellLineName,
    Expression<String>? species,
    Expression<String>? tissue,
    Expression<String>? genotype,
    Expression<String>? cultureMedium,
    Expression<String>? antibioticSelection,
    Expression<String>? storageLocation,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cellLineName != null) 'cell_line_name': cellLineName,
      if (species != null) 'species': species,
      if (tissue != null) 'tissue': tissue,
      if (genotype != null) 'genotype': genotype,
      if (cultureMedium != null) 'culture_medium': cultureMedium,
      if (antibioticSelection != null)
        'antibiotic_selection': antibioticSelection,
      if (storageLocation != null) 'storage_location': storageLocation,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CellLinesCompanion copyWith(
      {Value<int>? id,
      Value<String>? cellLineName,
      Value<String?>? species,
      Value<String?>? tissue,
      Value<String?>? genotype,
      Value<String?>? cultureMedium,
      Value<String?>? antibioticSelection,
      Value<String?>? storageLocation,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CellLinesCompanion(
      id: id ?? this.id,
      cellLineName: cellLineName ?? this.cellLineName,
      species: species ?? this.species,
      tissue: tissue ?? this.tissue,
      genotype: genotype ?? this.genotype,
      cultureMedium: cultureMedium ?? this.cultureMedium,
      antibioticSelection: antibioticSelection ?? this.antibioticSelection,
      storageLocation: storageLocation ?? this.storageLocation,
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
    if (cellLineName.present) {
      map['cell_line_name'] = Variable<String>(cellLineName.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (tissue.present) {
      map['tissue'] = Variable<String>(tissue.value);
    }
    if (genotype.present) {
      map['genotype'] = Variable<String>(genotype.value);
    }
    if (cultureMedium.present) {
      map['culture_medium'] = Variable<String>(cultureMedium.value);
    }
    if (antibioticSelection.present) {
      map['antibiotic_selection'] = Variable<String>(antibioticSelection.value);
    }
    if (storageLocation.present) {
      map['storage_location'] = Variable<String>(storageLocation.value);
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
    return (StringBuffer('CellLinesCompanion(')
          ..write('id: $id, ')
          ..write('cellLineName: $cellLineName, ')
          ..write('species: $species, ')
          ..write('tissue: $tissue, ')
          ..write('genotype: $genotype, ')
          ..write('cultureMedium: $cultureMedium, ')
          ..write('antibioticSelection: $antibioticSelection, ')
          ..write('storageLocation: $storageLocation, ')
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
  late final $CloningDetailsTable cloningDetails = $CloningDetailsTable(this);
  late final $TransfectionDetailsTable transfectionDetails =
      $TransfectionDetailsTable(this);
  late final $SirnaDetailsTable sirnaDetails = $SirnaDetailsTable(this);
  late final $PurificationDetailsTable purificationDetails =
      $PurificationDetailsTable(this);
  late final $PlasmidsTable plasmids = $PlasmidsTable(this);
  late final $CellLinesTable cellLines = $CellLinesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        experimentRecords,
        cloningDetails,
        transfectionDetails,
        sirnaDetails,
        purificationDetails,
        plasmids,
        cellLines
      ];
}

typedef $$ExperimentRecordsTableCreateCompanionBuilder
    = ExperimentRecordsCompanion Function({
  Value<int> id,
  Value<String> module,
  Value<String> title,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ExperimentRecordsTableUpdateCompanionBuilder
    = ExperimentRecordsCompanion Function({
  Value<int> id,
  Value<String> module,
  Value<String> title,
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
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ExperimentRecordsCompanion(
            id: id,
            module: module,
            title: title,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> module = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ExperimentRecordsCompanion.insert(
            id: id,
            module: module,
            title: title,
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
typedef $$CloningDetailsTableCreateCompanionBuilder = CloningDetailsCompanion
    Function({
  Value<int> id,
  required int experimentRecordId,
  Value<String?> cloningMethod,
  Value<String?> enzyme1,
  Value<String?> enzyme2,
  Value<String?> notes,
  Value<int?> vectorPlasmidId,
  Value<int?> insertPlasmidId,
  Value<int?> destinationPlasmidId,
});
typedef $$CloningDetailsTableUpdateCompanionBuilder = CloningDetailsCompanion
    Function({
  Value<int> id,
  Value<int> experimentRecordId,
  Value<String?> cloningMethod,
  Value<String?> enzyme1,
  Value<String?> enzyme2,
  Value<String?> notes,
  Value<int?> vectorPlasmidId,
  Value<int?> insertPlasmidId,
  Value<int?> destinationPlasmidId,
});

class $$CloningDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $CloningDetailsTable> {
  $$CloningDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cloningMethod => $composableBuilder(
      column: $table.cloningMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get enzyme1 => $composableBuilder(
      column: $table.enzyme1, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get enzyme2 => $composableBuilder(
      column: $table.enzyme2, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vectorPlasmidId => $composableBuilder(
      column: $table.vectorPlasmidId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get insertPlasmidId => $composableBuilder(
      column: $table.insertPlasmidId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get destinationPlasmidId => $composableBuilder(
      column: $table.destinationPlasmidId,
      builder: (column) => ColumnFilters(column));
}

class $$CloningDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $CloningDetailsTable> {
  $$CloningDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cloningMethod => $composableBuilder(
      column: $table.cloningMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get enzyme1 => $composableBuilder(
      column: $table.enzyme1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get enzyme2 => $composableBuilder(
      column: $table.enzyme2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vectorPlasmidId => $composableBuilder(
      column: $table.vectorPlasmidId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get insertPlasmidId => $composableBuilder(
      column: $table.insertPlasmidId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get destinationPlasmidId => $composableBuilder(
      column: $table.destinationPlasmidId,
      builder: (column) => ColumnOrderings(column));
}

class $$CloningDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CloningDetailsTable> {
  $$CloningDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId, builder: (column) => column);

  GeneratedColumn<String> get cloningMethod => $composableBuilder(
      column: $table.cloningMethod, builder: (column) => column);

  GeneratedColumn<String> get enzyme1 =>
      $composableBuilder(column: $table.enzyme1, builder: (column) => column);

  GeneratedColumn<String> get enzyme2 =>
      $composableBuilder(column: $table.enzyme2, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get vectorPlasmidId => $composableBuilder(
      column: $table.vectorPlasmidId, builder: (column) => column);

  GeneratedColumn<int> get insertPlasmidId => $composableBuilder(
      column: $table.insertPlasmidId, builder: (column) => column);

  GeneratedColumn<int> get destinationPlasmidId => $composableBuilder(
      column: $table.destinationPlasmidId, builder: (column) => column);
}

class $$CloningDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CloningDetailsTable,
    CloningDetail,
    $$CloningDetailsTableFilterComposer,
    $$CloningDetailsTableOrderingComposer,
    $$CloningDetailsTableAnnotationComposer,
    $$CloningDetailsTableCreateCompanionBuilder,
    $$CloningDetailsTableUpdateCompanionBuilder,
    (
      CloningDetail,
      BaseReferences<_$AppDatabase, $CloningDetailsTable, CloningDetail>
    ),
    CloningDetail,
    PrefetchHooks Function()> {
  $$CloningDetailsTableTableManager(
      _$AppDatabase db, $CloningDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CloningDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CloningDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CloningDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> experimentRecordId = const Value.absent(),
            Value<String?> cloningMethod = const Value.absent(),
            Value<String?> enzyme1 = const Value.absent(),
            Value<String?> enzyme2 = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int?> vectorPlasmidId = const Value.absent(),
            Value<int?> insertPlasmidId = const Value.absent(),
            Value<int?> destinationPlasmidId = const Value.absent(),
          }) =>
              CloningDetailsCompanion(
            id: id,
            experimentRecordId: experimentRecordId,
            cloningMethod: cloningMethod,
            enzyme1: enzyme1,
            enzyme2: enzyme2,
            notes: notes,
            vectorPlasmidId: vectorPlasmidId,
            insertPlasmidId: insertPlasmidId,
            destinationPlasmidId: destinationPlasmidId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int experimentRecordId,
            Value<String?> cloningMethod = const Value.absent(),
            Value<String?> enzyme1 = const Value.absent(),
            Value<String?> enzyme2 = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int?> vectorPlasmidId = const Value.absent(),
            Value<int?> insertPlasmidId = const Value.absent(),
            Value<int?> destinationPlasmidId = const Value.absent(),
          }) =>
              CloningDetailsCompanion.insert(
            id: id,
            experimentRecordId: experimentRecordId,
            cloningMethod: cloningMethod,
            enzyme1: enzyme1,
            enzyme2: enzyme2,
            notes: notes,
            vectorPlasmidId: vectorPlasmidId,
            insertPlasmidId: insertPlasmidId,
            destinationPlasmidId: destinationPlasmidId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CloningDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CloningDetailsTable,
    CloningDetail,
    $$CloningDetailsTableFilterComposer,
    $$CloningDetailsTableOrderingComposer,
    $$CloningDetailsTableAnnotationComposer,
    $$CloningDetailsTableCreateCompanionBuilder,
    $$CloningDetailsTableUpdateCompanionBuilder,
    (
      CloningDetail,
      BaseReferences<_$AppDatabase, $CloningDetailsTable, CloningDetail>
    ),
    CloningDetail,
    PrefetchHooks Function()>;
typedef $$TransfectionDetailsTableCreateCompanionBuilder
    = TransfectionDetailsCompanion Function({
  Value<int> id,
  required int experimentRecordId,
  Value<String?> cellLine,
  Value<String?> passageNumber,
  Value<String?> transfectionReagent,
  Value<String?> nucleicAcidType,
  Value<String?> nucleicAcidId,
  Value<String?> plateFormat,
  Value<String?> observationTimepoint,
  Value<String?> transfectionEfficiency,
  Value<String?> toxicityObservation,
  Value<String?> endpointResult,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$TransfectionDetailsTableUpdateCompanionBuilder
    = TransfectionDetailsCompanion Function({
  Value<int> id,
  Value<int> experimentRecordId,
  Value<String?> cellLine,
  Value<String?> passageNumber,
  Value<String?> transfectionReagent,
  Value<String?> nucleicAcidType,
  Value<String?> nucleicAcidId,
  Value<String?> plateFormat,
  Value<String?> observationTimepoint,
  Value<String?> transfectionEfficiency,
  Value<String?> toxicityObservation,
  Value<String?> endpointResult,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$TransfectionDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $TransfectionDetailsTable> {
  $$TransfectionDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cellLine => $composableBuilder(
      column: $table.cellLine, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passageNumber => $composableBuilder(
      column: $table.passageNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transfectionReagent => $composableBuilder(
      column: $table.transfectionReagent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nucleicAcidType => $composableBuilder(
      column: $table.nucleicAcidType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nucleicAcidId => $composableBuilder(
      column: $table.nucleicAcidId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plateFormat => $composableBuilder(
      column: $table.plateFormat, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observationTimepoint => $composableBuilder(
      column: $table.observationTimepoint,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transfectionEfficiency => $composableBuilder(
      column: $table.transfectionEfficiency,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toxicityObservation => $composableBuilder(
      column: $table.toxicityObservation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endpointResult => $composableBuilder(
      column: $table.endpointResult,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TransfectionDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransfectionDetailsTable> {
  $$TransfectionDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cellLine => $composableBuilder(
      column: $table.cellLine, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passageNumber => $composableBuilder(
      column: $table.passageNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transfectionReagent => $composableBuilder(
      column: $table.transfectionReagent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nucleicAcidType => $composableBuilder(
      column: $table.nucleicAcidType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nucleicAcidId => $composableBuilder(
      column: $table.nucleicAcidId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plateFormat => $composableBuilder(
      column: $table.plateFormat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observationTimepoint => $composableBuilder(
      column: $table.observationTimepoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transfectionEfficiency => $composableBuilder(
      column: $table.transfectionEfficiency,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toxicityObservation => $composableBuilder(
      column: $table.toxicityObservation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endpointResult => $composableBuilder(
      column: $table.endpointResult,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TransfectionDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransfectionDetailsTable> {
  $$TransfectionDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId, builder: (column) => column);

  GeneratedColumn<String> get cellLine =>
      $composableBuilder(column: $table.cellLine, builder: (column) => column);

  GeneratedColumn<String> get passageNumber => $composableBuilder(
      column: $table.passageNumber, builder: (column) => column);

  GeneratedColumn<String> get transfectionReagent => $composableBuilder(
      column: $table.transfectionReagent, builder: (column) => column);

  GeneratedColumn<String> get nucleicAcidType => $composableBuilder(
      column: $table.nucleicAcidType, builder: (column) => column);

  GeneratedColumn<String> get nucleicAcidId => $composableBuilder(
      column: $table.nucleicAcidId, builder: (column) => column);

  GeneratedColumn<String> get plateFormat => $composableBuilder(
      column: $table.plateFormat, builder: (column) => column);

  GeneratedColumn<String> get observationTimepoint => $composableBuilder(
      column: $table.observationTimepoint, builder: (column) => column);

  GeneratedColumn<String> get transfectionEfficiency => $composableBuilder(
      column: $table.transfectionEfficiency, builder: (column) => column);

  GeneratedColumn<String> get toxicityObservation => $composableBuilder(
      column: $table.toxicityObservation, builder: (column) => column);

  GeneratedColumn<String> get endpointResult => $composableBuilder(
      column: $table.endpointResult, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TransfectionDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransfectionDetailsTable,
    TransfectionDetail,
    $$TransfectionDetailsTableFilterComposer,
    $$TransfectionDetailsTableOrderingComposer,
    $$TransfectionDetailsTableAnnotationComposer,
    $$TransfectionDetailsTableCreateCompanionBuilder,
    $$TransfectionDetailsTableUpdateCompanionBuilder,
    (
      TransfectionDetail,
      BaseReferences<_$AppDatabase, $TransfectionDetailsTable,
          TransfectionDetail>
    ),
    TransfectionDetail,
    PrefetchHooks Function()> {
  $$TransfectionDetailsTableTableManager(
      _$AppDatabase db, $TransfectionDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransfectionDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransfectionDetailsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransfectionDetailsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> experimentRecordId = const Value.absent(),
            Value<String?> cellLine = const Value.absent(),
            Value<String?> passageNumber = const Value.absent(),
            Value<String?> transfectionReagent = const Value.absent(),
            Value<String?> nucleicAcidType = const Value.absent(),
            Value<String?> nucleicAcidId = const Value.absent(),
            Value<String?> plateFormat = const Value.absent(),
            Value<String?> observationTimepoint = const Value.absent(),
            Value<String?> transfectionEfficiency = const Value.absent(),
            Value<String?> toxicityObservation = const Value.absent(),
            Value<String?> endpointResult = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              TransfectionDetailsCompanion(
            id: id,
            experimentRecordId: experimentRecordId,
            cellLine: cellLine,
            passageNumber: passageNumber,
            transfectionReagent: transfectionReagent,
            nucleicAcidType: nucleicAcidType,
            nucleicAcidId: nucleicAcidId,
            plateFormat: plateFormat,
            observationTimepoint: observationTimepoint,
            transfectionEfficiency: transfectionEfficiency,
            toxicityObservation: toxicityObservation,
            endpointResult: endpointResult,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int experimentRecordId,
            Value<String?> cellLine = const Value.absent(),
            Value<String?> passageNumber = const Value.absent(),
            Value<String?> transfectionReagent = const Value.absent(),
            Value<String?> nucleicAcidType = const Value.absent(),
            Value<String?> nucleicAcidId = const Value.absent(),
            Value<String?> plateFormat = const Value.absent(),
            Value<String?> observationTimepoint = const Value.absent(),
            Value<String?> transfectionEfficiency = const Value.absent(),
            Value<String?> toxicityObservation = const Value.absent(),
            Value<String?> endpointResult = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              TransfectionDetailsCompanion.insert(
            id: id,
            experimentRecordId: experimentRecordId,
            cellLine: cellLine,
            passageNumber: passageNumber,
            transfectionReagent: transfectionReagent,
            nucleicAcidType: nucleicAcidType,
            nucleicAcidId: nucleicAcidId,
            plateFormat: plateFormat,
            observationTimepoint: observationTimepoint,
            transfectionEfficiency: transfectionEfficiency,
            toxicityObservation: toxicityObservation,
            endpointResult: endpointResult,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransfectionDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransfectionDetailsTable,
    TransfectionDetail,
    $$TransfectionDetailsTableFilterComposer,
    $$TransfectionDetailsTableOrderingComposer,
    $$TransfectionDetailsTableAnnotationComposer,
    $$TransfectionDetailsTableCreateCompanionBuilder,
    $$TransfectionDetailsTableUpdateCompanionBuilder,
    (
      TransfectionDetail,
      BaseReferences<_$AppDatabase, $TransfectionDetailsTable,
          TransfectionDetail>
    ),
    TransfectionDetail,
    PrefetchHooks Function()>;
typedef $$SirnaDetailsTableCreateCompanionBuilder = SirnaDetailsCompanion
    Function({
  Value<int> id,
  required int experimentRecordId,
  Value<String?> targetGene,
  Value<String?> sirnaName,
  Value<String?> sequence,
  Value<String?> concentration,
  Value<String?> transfectionReagent,
  Value<String?> notes,
});
typedef $$SirnaDetailsTableUpdateCompanionBuilder = SirnaDetailsCompanion
    Function({
  Value<int> id,
  Value<int> experimentRecordId,
  Value<String?> targetGene,
  Value<String?> sirnaName,
  Value<String?> sequence,
  Value<String?> concentration,
  Value<String?> transfectionReagent,
  Value<String?> notes,
});

class $$SirnaDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $SirnaDetailsTable> {
  $$SirnaDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetGene => $composableBuilder(
      column: $table.targetGene, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sirnaName => $composableBuilder(
      column: $table.sirnaName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sequence => $composableBuilder(
      column: $table.sequence, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get concentration => $composableBuilder(
      column: $table.concentration, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transfectionReagent => $composableBuilder(
      column: $table.transfectionReagent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$SirnaDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $SirnaDetailsTable> {
  $$SirnaDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetGene => $composableBuilder(
      column: $table.targetGene, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sirnaName => $composableBuilder(
      column: $table.sirnaName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sequence => $composableBuilder(
      column: $table.sequence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get concentration => $composableBuilder(
      column: $table.concentration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transfectionReagent => $composableBuilder(
      column: $table.transfectionReagent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$SirnaDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SirnaDetailsTable> {
  $$SirnaDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId, builder: (column) => column);

  GeneratedColumn<String> get targetGene => $composableBuilder(
      column: $table.targetGene, builder: (column) => column);

  GeneratedColumn<String> get sirnaName =>
      $composableBuilder(column: $table.sirnaName, builder: (column) => column);

  GeneratedColumn<String> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);

  GeneratedColumn<String> get concentration => $composableBuilder(
      column: $table.concentration, builder: (column) => column);

  GeneratedColumn<String> get transfectionReagent => $composableBuilder(
      column: $table.transfectionReagent, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$SirnaDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SirnaDetailsTable,
    SirnaDetail,
    $$SirnaDetailsTableFilterComposer,
    $$SirnaDetailsTableOrderingComposer,
    $$SirnaDetailsTableAnnotationComposer,
    $$SirnaDetailsTableCreateCompanionBuilder,
    $$SirnaDetailsTableUpdateCompanionBuilder,
    (
      SirnaDetail,
      BaseReferences<_$AppDatabase, $SirnaDetailsTable, SirnaDetail>
    ),
    SirnaDetail,
    PrefetchHooks Function()> {
  $$SirnaDetailsTableTableManager(_$AppDatabase db, $SirnaDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SirnaDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SirnaDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SirnaDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> experimentRecordId = const Value.absent(),
            Value<String?> targetGene = const Value.absent(),
            Value<String?> sirnaName = const Value.absent(),
            Value<String?> sequence = const Value.absent(),
            Value<String?> concentration = const Value.absent(),
            Value<String?> transfectionReagent = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              SirnaDetailsCompanion(
            id: id,
            experimentRecordId: experimentRecordId,
            targetGene: targetGene,
            sirnaName: sirnaName,
            sequence: sequence,
            concentration: concentration,
            transfectionReagent: transfectionReagent,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int experimentRecordId,
            Value<String?> targetGene = const Value.absent(),
            Value<String?> sirnaName = const Value.absent(),
            Value<String?> sequence = const Value.absent(),
            Value<String?> concentration = const Value.absent(),
            Value<String?> transfectionReagent = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              SirnaDetailsCompanion.insert(
            id: id,
            experimentRecordId: experimentRecordId,
            targetGene: targetGene,
            sirnaName: sirnaName,
            sequence: sequence,
            concentration: concentration,
            transfectionReagent: transfectionReagent,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SirnaDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SirnaDetailsTable,
    SirnaDetail,
    $$SirnaDetailsTableFilterComposer,
    $$SirnaDetailsTableOrderingComposer,
    $$SirnaDetailsTableAnnotationComposer,
    $$SirnaDetailsTableCreateCompanionBuilder,
    $$SirnaDetailsTableUpdateCompanionBuilder,
    (
      SirnaDetail,
      BaseReferences<_$AppDatabase, $SirnaDetailsTable, SirnaDetail>
    ),
    SirnaDetail,
    PrefetchHooks Function()>;
typedef $$PurificationDetailsTableCreateCompanionBuilder
    = PurificationDetailsCompanion Function({
  Value<int> id,
  required int experimentRecordId,
  Value<String?> sampleName,
  Value<String?> purificationMethod,
  Value<String?> bufferComposition,
  Value<String?> elutionCondition,
  Value<String?> yieldAmount,
  Value<String?> notes,
});
typedef $$PurificationDetailsTableUpdateCompanionBuilder
    = PurificationDetailsCompanion Function({
  Value<int> id,
  Value<int> experimentRecordId,
  Value<String?> sampleName,
  Value<String?> purificationMethod,
  Value<String?> bufferComposition,
  Value<String?> elutionCondition,
  Value<String?> yieldAmount,
  Value<String?> notes,
});

class $$PurificationDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $PurificationDetailsTable> {
  $$PurificationDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sampleName => $composableBuilder(
      column: $table.sampleName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get purificationMethod => $composableBuilder(
      column: $table.purificationMethod,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bufferComposition => $composableBuilder(
      column: $table.bufferComposition,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get elutionCondition => $composableBuilder(
      column: $table.elutionCondition,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get yieldAmount => $composableBuilder(
      column: $table.yieldAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$PurificationDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurificationDetailsTable> {
  $$PurificationDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sampleName => $composableBuilder(
      column: $table.sampleName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get purificationMethod => $composableBuilder(
      column: $table.purificationMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bufferComposition => $composableBuilder(
      column: $table.bufferComposition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get elutionCondition => $composableBuilder(
      column: $table.elutionCondition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get yieldAmount => $composableBuilder(
      column: $table.yieldAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$PurificationDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurificationDetailsTable> {
  $$PurificationDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get experimentRecordId => $composableBuilder(
      column: $table.experimentRecordId, builder: (column) => column);

  GeneratedColumn<String> get sampleName => $composableBuilder(
      column: $table.sampleName, builder: (column) => column);

  GeneratedColumn<String> get purificationMethod => $composableBuilder(
      column: $table.purificationMethod, builder: (column) => column);

  GeneratedColumn<String> get bufferComposition => $composableBuilder(
      column: $table.bufferComposition, builder: (column) => column);

  GeneratedColumn<String> get elutionCondition => $composableBuilder(
      column: $table.elutionCondition, builder: (column) => column);

  GeneratedColumn<String> get yieldAmount => $composableBuilder(
      column: $table.yieldAmount, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$PurificationDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PurificationDetailsTable,
    PurificationDetail,
    $$PurificationDetailsTableFilterComposer,
    $$PurificationDetailsTableOrderingComposer,
    $$PurificationDetailsTableAnnotationComposer,
    $$PurificationDetailsTableCreateCompanionBuilder,
    $$PurificationDetailsTableUpdateCompanionBuilder,
    (
      PurificationDetail,
      BaseReferences<_$AppDatabase, $PurificationDetailsTable,
          PurificationDetail>
    ),
    PurificationDetail,
    PrefetchHooks Function()> {
  $$PurificationDetailsTableTableManager(
      _$AppDatabase db, $PurificationDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurificationDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurificationDetailsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurificationDetailsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> experimentRecordId = const Value.absent(),
            Value<String?> sampleName = const Value.absent(),
            Value<String?> purificationMethod = const Value.absent(),
            Value<String?> bufferComposition = const Value.absent(),
            Value<String?> elutionCondition = const Value.absent(),
            Value<String?> yieldAmount = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PurificationDetailsCompanion(
            id: id,
            experimentRecordId: experimentRecordId,
            sampleName: sampleName,
            purificationMethod: purificationMethod,
            bufferComposition: bufferComposition,
            elutionCondition: elutionCondition,
            yieldAmount: yieldAmount,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int experimentRecordId,
            Value<String?> sampleName = const Value.absent(),
            Value<String?> purificationMethod = const Value.absent(),
            Value<String?> bufferComposition = const Value.absent(),
            Value<String?> elutionCondition = const Value.absent(),
            Value<String?> yieldAmount = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              PurificationDetailsCompanion.insert(
            id: id,
            experimentRecordId: experimentRecordId,
            sampleName: sampleName,
            purificationMethod: purificationMethod,
            bufferComposition: bufferComposition,
            elutionCondition: elutionCondition,
            yieldAmount: yieldAmount,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PurificationDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PurificationDetailsTable,
    PurificationDetail,
    $$PurificationDetailsTableFilterComposer,
    $$PurificationDetailsTableOrderingComposer,
    $$PurificationDetailsTableAnnotationComposer,
    $$PurificationDetailsTableCreateCompanionBuilder,
    $$PurificationDetailsTableUpdateCompanionBuilder,
    (
      PurificationDetail,
      BaseReferences<_$AppDatabase, $PurificationDetailsTable,
          PurificationDetail>
    ),
    PurificationDetail,
    PrefetchHooks Function()>;
typedef $$PlasmidsTableCreateCompanionBuilder = PlasmidsCompanion Function({
  Value<int> id,
  required String plasmidName,
  Value<String?> alias,
  Value<String> sourceType,
  Value<String?> addgeneId,
  Value<String?> backbone,
  Value<String?> insertGene,
  Value<String?> promoter,
  Value<String?> tag,
  Value<String?> bacterialAntibiotic,
  Value<String?> mammalianSelection,
  Value<String?> ori,
  Value<int?> sizeBp,
  Value<String?> genbankUrl,
  Value<String?> snapgeneUrl,
  Value<String?> notes,
  Value<bool> isCloningSelectable,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PlasmidsTableUpdateCompanionBuilder = PlasmidsCompanion Function({
  Value<int> id,
  Value<String> plasmidName,
  Value<String?> alias,
  Value<String> sourceType,
  Value<String?> addgeneId,
  Value<String?> backbone,
  Value<String?> insertGene,
  Value<String?> promoter,
  Value<String?> tag,
  Value<String?> bacterialAntibiotic,
  Value<String?> mammalianSelection,
  Value<String?> ori,
  Value<int?> sizeBp,
  Value<String?> genbankUrl,
  Value<String?> snapgeneUrl,
  Value<String?> notes,
  Value<bool> isCloningSelectable,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$PlasmidsTableFilterComposer
    extends Composer<_$AppDatabase, $PlasmidsTable> {
  $$PlasmidsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plasmidName => $composableBuilder(
      column: $table.plasmidName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get alias => $composableBuilder(
      column: $table.alias, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get addgeneId => $composableBuilder(
      column: $table.addgeneId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backbone => $composableBuilder(
      column: $table.backbone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insertGene => $composableBuilder(
      column: $table.insertGene, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get promoter => $composableBuilder(
      column: $table.promoter, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bacterialAntibiotic => $composableBuilder(
      column: $table.bacterialAntibiotic,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mammalianSelection => $composableBuilder(
      column: $table.mammalianSelection,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ori => $composableBuilder(
      column: $table.ori, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sizeBp => $composableBuilder(
      column: $table.sizeBp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genbankUrl => $composableBuilder(
      column: $table.genbankUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get snapgeneUrl => $composableBuilder(
      column: $table.snapgeneUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCloningSelectable => $composableBuilder(
      column: $table.isCloningSelectable,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PlasmidsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlasmidsTable> {
  $$PlasmidsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plasmidName => $composableBuilder(
      column: $table.plasmidName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alias => $composableBuilder(
      column: $table.alias, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get addgeneId => $composableBuilder(
      column: $table.addgeneId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backbone => $composableBuilder(
      column: $table.backbone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insertGene => $composableBuilder(
      column: $table.insertGene, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get promoter => $composableBuilder(
      column: $table.promoter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tag => $composableBuilder(
      column: $table.tag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bacterialAntibiotic => $composableBuilder(
      column: $table.bacterialAntibiotic,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mammalianSelection => $composableBuilder(
      column: $table.mammalianSelection,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ori => $composableBuilder(
      column: $table.ori, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sizeBp => $composableBuilder(
      column: $table.sizeBp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genbankUrl => $composableBuilder(
      column: $table.genbankUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get snapgeneUrl => $composableBuilder(
      column: $table.snapgeneUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCloningSelectable => $composableBuilder(
      column: $table.isCloningSelectable,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PlasmidsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlasmidsTable> {
  $$PlasmidsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get plasmidName => $composableBuilder(
      column: $table.plasmidName, builder: (column) => column);

  GeneratedColumn<String> get alias =>
      $composableBuilder(column: $table.alias, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => column);

  GeneratedColumn<String> get addgeneId =>
      $composableBuilder(column: $table.addgeneId, builder: (column) => column);

  GeneratedColumn<String> get backbone =>
      $composableBuilder(column: $table.backbone, builder: (column) => column);

  GeneratedColumn<String> get insertGene => $composableBuilder(
      column: $table.insertGene, builder: (column) => column);

  GeneratedColumn<String> get promoter =>
      $composableBuilder(column: $table.promoter, builder: (column) => column);

  GeneratedColumn<String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<String> get bacterialAntibiotic => $composableBuilder(
      column: $table.bacterialAntibiotic, builder: (column) => column);

  GeneratedColumn<String> get mammalianSelection => $composableBuilder(
      column: $table.mammalianSelection, builder: (column) => column);

  GeneratedColumn<String> get ori =>
      $composableBuilder(column: $table.ori, builder: (column) => column);

  GeneratedColumn<int> get sizeBp =>
      $composableBuilder(column: $table.sizeBp, builder: (column) => column);

  GeneratedColumn<String> get genbankUrl => $composableBuilder(
      column: $table.genbankUrl, builder: (column) => column);

  GeneratedColumn<String> get snapgeneUrl => $composableBuilder(
      column: $table.snapgeneUrl, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isCloningSelectable => $composableBuilder(
      column: $table.isCloningSelectable, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PlasmidsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlasmidsTable,
    Plasmid,
    $$PlasmidsTableFilterComposer,
    $$PlasmidsTableOrderingComposer,
    $$PlasmidsTableAnnotationComposer,
    $$PlasmidsTableCreateCompanionBuilder,
    $$PlasmidsTableUpdateCompanionBuilder,
    (Plasmid, BaseReferences<_$AppDatabase, $PlasmidsTable, Plasmid>),
    Plasmid,
    PrefetchHooks Function()> {
  $$PlasmidsTableTableManager(_$AppDatabase db, $PlasmidsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlasmidsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlasmidsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlasmidsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> plasmidName = const Value.absent(),
            Value<String?> alias = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String?> addgeneId = const Value.absent(),
            Value<String?> backbone = const Value.absent(),
            Value<String?> insertGene = const Value.absent(),
            Value<String?> promoter = const Value.absent(),
            Value<String?> tag = const Value.absent(),
            Value<String?> bacterialAntibiotic = const Value.absent(),
            Value<String?> mammalianSelection = const Value.absent(),
            Value<String?> ori = const Value.absent(),
            Value<int?> sizeBp = const Value.absent(),
            Value<String?> genbankUrl = const Value.absent(),
            Value<String?> snapgeneUrl = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isCloningSelectable = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PlasmidsCompanion(
            id: id,
            plasmidName: plasmidName,
            alias: alias,
            sourceType: sourceType,
            addgeneId: addgeneId,
            backbone: backbone,
            insertGene: insertGene,
            promoter: promoter,
            tag: tag,
            bacterialAntibiotic: bacterialAntibiotic,
            mammalianSelection: mammalianSelection,
            ori: ori,
            sizeBp: sizeBp,
            genbankUrl: genbankUrl,
            snapgeneUrl: snapgeneUrl,
            notes: notes,
            isCloningSelectable: isCloningSelectable,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String plasmidName,
            Value<String?> alias = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String?> addgeneId = const Value.absent(),
            Value<String?> backbone = const Value.absent(),
            Value<String?> insertGene = const Value.absent(),
            Value<String?> promoter = const Value.absent(),
            Value<String?> tag = const Value.absent(),
            Value<String?> bacterialAntibiotic = const Value.absent(),
            Value<String?> mammalianSelection = const Value.absent(),
            Value<String?> ori = const Value.absent(),
            Value<int?> sizeBp = const Value.absent(),
            Value<String?> genbankUrl = const Value.absent(),
            Value<String?> snapgeneUrl = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isCloningSelectable = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PlasmidsCompanion.insert(
            id: id,
            plasmidName: plasmidName,
            alias: alias,
            sourceType: sourceType,
            addgeneId: addgeneId,
            backbone: backbone,
            insertGene: insertGene,
            promoter: promoter,
            tag: tag,
            bacterialAntibiotic: bacterialAntibiotic,
            mammalianSelection: mammalianSelection,
            ori: ori,
            sizeBp: sizeBp,
            genbankUrl: genbankUrl,
            snapgeneUrl: snapgeneUrl,
            notes: notes,
            isCloningSelectable: isCloningSelectable,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlasmidsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlasmidsTable,
    Plasmid,
    $$PlasmidsTableFilterComposer,
    $$PlasmidsTableOrderingComposer,
    $$PlasmidsTableAnnotationComposer,
    $$PlasmidsTableCreateCompanionBuilder,
    $$PlasmidsTableUpdateCompanionBuilder,
    (Plasmid, BaseReferences<_$AppDatabase, $PlasmidsTable, Plasmid>),
    Plasmid,
    PrefetchHooks Function()>;
typedef $$CellLinesTableCreateCompanionBuilder = CellLinesCompanion Function({
  Value<int> id,
  required String cellLineName,
  Value<String?> species,
  Value<String?> tissue,
  Value<String?> genotype,
  Value<String?> cultureMedium,
  Value<String?> antibioticSelection,
  Value<String?> storageLocation,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$CellLinesTableUpdateCompanionBuilder = CellLinesCompanion Function({
  Value<int> id,
  Value<String> cellLineName,
  Value<String?> species,
  Value<String?> tissue,
  Value<String?> genotype,
  Value<String?> cultureMedium,
  Value<String?> antibioticSelection,
  Value<String?> storageLocation,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$CellLinesTableFilterComposer
    extends Composer<_$AppDatabase, $CellLinesTable> {
  $$CellLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cellLineName => $composableBuilder(
      column: $table.cellLineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get species => $composableBuilder(
      column: $table.species, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tissue => $composableBuilder(
      column: $table.tissue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genotype => $composableBuilder(
      column: $table.genotype, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cultureMedium => $composableBuilder(
      column: $table.cultureMedium, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get antibioticSelection => $composableBuilder(
      column: $table.antibioticSelection,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CellLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $CellLinesTable> {
  $$CellLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cellLineName => $composableBuilder(
      column: $table.cellLineName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get species => $composableBuilder(
      column: $table.species, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tissue => $composableBuilder(
      column: $table.tissue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genotype => $composableBuilder(
      column: $table.genotype, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cultureMedium => $composableBuilder(
      column: $table.cultureMedium,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get antibioticSelection => $composableBuilder(
      column: $table.antibioticSelection,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CellLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CellLinesTable> {
  $$CellLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cellLineName => $composableBuilder(
      column: $table.cellLineName, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get tissue =>
      $composableBuilder(column: $table.tissue, builder: (column) => column);

  GeneratedColumn<String> get genotype =>
      $composableBuilder(column: $table.genotype, builder: (column) => column);

  GeneratedColumn<String> get cultureMedium => $composableBuilder(
      column: $table.cultureMedium, builder: (column) => column);

  GeneratedColumn<String> get antibioticSelection => $composableBuilder(
      column: $table.antibioticSelection, builder: (column) => column);

  GeneratedColumn<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CellLinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CellLinesTable,
    CellLine,
    $$CellLinesTableFilterComposer,
    $$CellLinesTableOrderingComposer,
    $$CellLinesTableAnnotationComposer,
    $$CellLinesTableCreateCompanionBuilder,
    $$CellLinesTableUpdateCompanionBuilder,
    (CellLine, BaseReferences<_$AppDatabase, $CellLinesTable, CellLine>),
    CellLine,
    PrefetchHooks Function()> {
  $$CellLinesTableTableManager(_$AppDatabase db, $CellLinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CellLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CellLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CellLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> cellLineName = const Value.absent(),
            Value<String?> species = const Value.absent(),
            Value<String?> tissue = const Value.absent(),
            Value<String?> genotype = const Value.absent(),
            Value<String?> cultureMedium = const Value.absent(),
            Value<String?> antibioticSelection = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CellLinesCompanion(
            id: id,
            cellLineName: cellLineName,
            species: species,
            tissue: tissue,
            genotype: genotype,
            cultureMedium: cultureMedium,
            antibioticSelection: antibioticSelection,
            storageLocation: storageLocation,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String cellLineName,
            Value<String?> species = const Value.absent(),
            Value<String?> tissue = const Value.absent(),
            Value<String?> genotype = const Value.absent(),
            Value<String?> cultureMedium = const Value.absent(),
            Value<String?> antibioticSelection = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              CellLinesCompanion.insert(
            id: id,
            cellLineName: cellLineName,
            species: species,
            tissue: tissue,
            genotype: genotype,
            cultureMedium: cultureMedium,
            antibioticSelection: antibioticSelection,
            storageLocation: storageLocation,
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

typedef $$CellLinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CellLinesTable,
    CellLine,
    $$CellLinesTableFilterComposer,
    $$CellLinesTableOrderingComposer,
    $$CellLinesTableAnnotationComposer,
    $$CellLinesTableCreateCompanionBuilder,
    $$CellLinesTableUpdateCompanionBuilder,
    (CellLine, BaseReferences<_$AppDatabase, $CellLinesTable, CellLine>),
    CellLine,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExperimentRecordsTableTableManager get experimentRecords =>
      $$ExperimentRecordsTableTableManager(_db, _db.experimentRecords);
  $$CloningDetailsTableTableManager get cloningDetails =>
      $$CloningDetailsTableTableManager(_db, _db.cloningDetails);
  $$TransfectionDetailsTableTableManager get transfectionDetails =>
      $$TransfectionDetailsTableTableManager(_db, _db.transfectionDetails);
  $$SirnaDetailsTableTableManager get sirnaDetails =>
      $$SirnaDetailsTableTableManager(_db, _db.sirnaDetails);
  $$PurificationDetailsTableTableManager get purificationDetails =>
      $$PurificationDetailsTableTableManager(_db, _db.purificationDetails);
  $$PlasmidsTableTableManager get plasmids =>
      $$PlasmidsTableTableManager(_db, _db.plasmids);
  $$CellLinesTableTableManager get cellLines =>
      $$CellLinesTableTableManager(_db, _db.cellLines);
}
