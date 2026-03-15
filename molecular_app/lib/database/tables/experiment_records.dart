import 'package:drift/drift.dart';

class ExperimentRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get module => text()();
  TextColumn get title => text()();
  TextColumn get objective => text().nullable()();
  TextColumn get sampleId => text().nullable()();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}