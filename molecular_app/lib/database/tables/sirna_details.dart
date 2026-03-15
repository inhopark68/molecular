import 'package:drift/drift.dart';

import 'experiment_records.dart';

class SirnaDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId =>
      integer().references(ExperimentRecords, #id)();

  TextColumn get targetGene => text().nullable()();
  TextColumn get sirnaName => text().nullable()();
  TextColumn get sequence => text().nullable()();
  TextColumn get concentration => text().nullable()();
  TextColumn get transfectionReagent => text().nullable()();
  TextColumn get notes => text().nullable()();
}