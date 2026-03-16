import 'package:drift/drift.dart';

@DataClassName('ExperimentRecord')
class ExperimentRecords extends Table {
  @override
  String get tableName => 'experiment_records';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get module => text()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}