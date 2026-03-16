import 'package:drift/drift.dart';

class ExperimentRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withDefault(const Constant(''))();

  TextColumn get notes => text().nullable()();
}