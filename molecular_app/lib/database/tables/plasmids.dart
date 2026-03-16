import 'package:drift/drift.dart';

class Plasmids extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get plasmidName => text()();
  TextColumn get alias => text().nullable()();

  TextColumn get sourceType =>
      text().withDefault(const Constant('custom'))();

  TextColumn get addgeneId => text().nullable()();
  TextColumn get backbone => text().nullable()();
  TextColumn get insertGene => text().nullable()();
  TextColumn get promoter => text().nullable()();
  TextColumn get tag => text().nullable()();
  TextColumn get bacterialAntibiotic => text().nullable()();
  TextColumn get mammalianSelection => text().nullable()();
  TextColumn get ori => text().nullable()();
  IntColumn get sizeBp => integer().nullable()();

  TextColumn get genbankUrl => text().nullable()();
  TextColumn get snapgeneUrl => text().nullable()();
  TextColumn get notes => text().nullable()();

  BoolColumn get isCloningSelectable =>
      boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}