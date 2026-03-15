import 'package:drift/drift.dart';

import 'experiment_records.dart';

class CloningDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId => integer().references(
        ExperimentRecords,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get plasmidName =>
      text().withDefault(const Constant(''))();

  TextColumn get plasmidFrame =>
      text().nullable()();

  TextColumn get insertDirection =>
      text().nullable()();

  TextColumn get fivePrimeRestrictionSite =>
      text().withDefault(const Constant(''))();

  TextColumn get threePrimeRestrictionSite =>
      text().withDefault(const Constant(''))();

  TextColumn get insertGeneName =>
      text().withDefault(const Constant(''))();

  IntColumn get insertLengthBp =>
      integer().nullable()();

  TextColumn get geneSource =>
      text().withDefault(const Constant(''))();

  TextColumn get geneSequence =>
      text().withDefault(const Constant(''))();

  TextColumn get expressionHost =>
      text().withDefault(const Constant(''))();

  TextColumn get inductionOd600 =>
      text().withDefault(const Constant('0.4-0.6'))();

  RealColumn get iptgMm =>
      real().nullable()();

  RealColumn get temperatureC =>
      real().nullable()();

  TextColumn get inductionTimeHours =>
      text().withDefault(const Constant('4-6'))();

  TextColumn get purificationMethod =>
      text().withDefault(const Constant('Ni-NTA (His tag)'))();

  BoolColumn get hasHisTag =>
      boolean().withDefault(const Constant(true))();

  BoolColumn get hasXpressEpitope =>
      boolean().withDefault(const Constant(true))();
}