import 'package:drift/drift.dart';

import 'experiment_records.dart';

class PurificationDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId =>
      integer().references(ExperimentRecords, #id)();

  TextColumn get sampleName => text().nullable()();
  TextColumn get purificationMethod => text().nullable()();
  TextColumn get bufferComposition => text().nullable()();
  TextColumn get elutionCondition => text().nullable()();
  TextColumn get yieldAmount => text().nullable()();
  TextColumn get notes => text().nullable()();
}