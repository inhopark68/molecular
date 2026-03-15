import 'package:drift/drift.dart';

class Plasmids extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get plasmidName => text()();
  TextColumn get backbone => text().nullable()();
  TextColumn get insertGene => text().nullable()();
  TextColumn get tag => text().nullable()();
  TextColumn get promoter => text().nullable()();
  TextColumn get antibioticResistance => text().nullable()();
  TextColumn get origin => text().nullable()();
  TextColumn get cloningStatus => text().nullable()();
  BoolColumn get sequenceVerified =>
      boolean().withDefault(const Constant(false))();
  TextColumn get storageLocation => text().nullable()();
  TextColumn get concentration => text().nullable()();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}