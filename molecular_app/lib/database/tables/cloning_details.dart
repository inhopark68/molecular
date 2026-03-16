import 'package:drift/drift.dart';

import 'experiment_records.dart';
import 'plasmids.dart';

class CloningDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId =>
      integer().references(ExperimentRecords, #id)();

  TextColumn get cloningMethod => text().nullable()();
  TextColumn get enzyme1 => text().nullable()();
  TextColumn get enzyme2 => text().nullable()();
  TextColumn get notes => text().nullable()();

  IntColumn get vectorPlasmidId =>
      integer().nullable().references(Plasmids, #id)();

  IntColumn get insertPlasmidId =>
      integer().nullable().references(Plasmids, #id)();

  IntColumn get destinationPlasmidId =>
      integer().nullable().references(Plasmids, #id)();
}