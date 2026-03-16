import 'package:drift/drift.dart';

class ExperimentRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get module => text().withDefault(const Constant('General'))();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}