import '../../database/drift.dart';

class CellLines extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get cellLineName => text()();
  TextColumn get species => text().nullable()();
  TextColumn get tissue => text().nullable()();
  TextColumn get genotype => text().nullable()();
  TextColumn get cultureMedium => text().nullable()();
  TextColumn get antibioticSelection => text().nullable()();
  TextColumn get storageLocation => text().nullable()();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}