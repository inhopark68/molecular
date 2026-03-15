import 'package:drift/drift.dart';
import 'experiment_records.dart';

class CloningDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId => integer().references(ExperimentRecords, #id)();

  TextColumn get vector => text().nullable()();
  TextColumn get insertName => text().nullable()();
  TextColumn get tag => text().nullable()();
  TextColumn get selectionMarker => text().nullable()();
  TextColumn get expectedConstructSize => text().nullable()();
  TextColumn get cloneId => text().nullable()();
  TextColumn get screeningResult => text().nullable()();
  TextColumn get sequencingResult => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}