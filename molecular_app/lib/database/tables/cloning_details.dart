import 'package:drift/drift.dart';
import 'experiment_records.dart';

class CloningDetails extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId => integer().references(
        ExperimentRecords,
        #id,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get plasmidName => text().withDefault(const Constant(''))();

  TextColumn get plasmidFrame => text().nullable()();

  TextColumn get insertDirection => text().nullable()();

  TextColumn get fivePrimeRestrictionSite =>
      text().withDefault(const Constant(''))();

  TextColumn get threePrimeRestrictionSite =>
      text().withDefault(const Constant(''))();

  TextColumn get insertGeneName => text().withDefault(const Constant(''))();

  IntColumn get insertLengthBp => integer().nullable()();

  TextColumn get geneSource => text().withDefault(const Constant(''))();

  TextColumn get geneSequence => text().withDefault(const Constant(''))();

  TextColumn get screeningMethod =>
      text().withDefault(const Constant('Colony PCR'))();

  TextColumn get selectedColony => text().withDefault(const Constant(''))();

  BoolColumn get restrictionDigestConfirmed =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get colonyPcrConfirmed =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get miniprepDone =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get insertSequenceVerified =>
      boolean().withDefault(const Constant(false))();

  TextColumn get sequencingPrimer =>
      text().withDefault(const Constant('T7 promoter'))();

  TextColumn get screeningNotes => text().withDefault(const Constant(''))();

  TextColumn get vectorNotes => text().withDefault(const Constant(''))();

  TextColumn get summaryJson => text().withDefault(const Constant('{}'))();
}