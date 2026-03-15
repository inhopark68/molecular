import 'package:drift/drift.dart';
import 'experiment_records.dart';

class TransfectionDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId =>
      integer().references(ExperimentRecords, #id)();

  TextColumn get cellLine => text().nullable()();
  TextColumn get passageNumber => text().nullable()();
  TextColumn get transfectionReagent => text().nullable()();
  TextColumn get nucleicAcidType => text().nullable()();
  TextColumn get nucleicAcidId => text().nullable()();
  TextColumn get plateFormat => text().nullable()();
  TextColumn get observationTimepoint => text().nullable()();
  TextColumn get transfectionEfficiency => text().nullable()();
  TextColumn get toxicityObservation => text().nullable()();
  TextColumn get endpointResult => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}