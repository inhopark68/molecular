import 'package:drift/drift.dart';
import 'experiment_records.dart';

@DataClassName('CloningDetail')
class CloningDetails extends Table {
  @override
  String get tableName => 'cloning_details';

  IntColumn get id => integer().autoIncrement()();

  IntColumn get experimentRecordId =>
      integer().references(ExperimentRecords, #id)();

  TextColumn get experimentTitle => text().nullable()();
  TextColumn get researcher => text().nullable()();
  DateTimeColumn get experimentDate => dateTime().nullable()();

  TextColumn get plasmidName => text().nullable()();
  TextColumn get plasmidFrame => text().nullable()();
  TextColumn get insertDirection => text().nullable()();
  TextColumn get vectorNotes => text().nullable()();

  TextColumn get fivePrimeRestrictionSite => text().nullable()();
  TextColumn get threePrimeRestrictionSite => text().nullable()();

  TextColumn get geneName => text().nullable()();
  IntColumn get insertLengthBp => integer().nullable()();
  TextColumn get geneSequence => text().nullable()();
  TextColumn get geneSource => text().nullable()();

  TextColumn get hostBacteria => text().nullable()();
  TextColumn get selectionAntibiotic => text().nullable()();
  IntColumn get positiveCloneCount => integer().nullable()();
  TextColumn get transformationNotes => text().nullable()();

  TextColumn get screeningMethod => text().nullable()();
  TextColumn get selectedColony => text().nullable()();
  BoolColumn get restrictionDigestConfirmed =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get colonyPcrConfirmed =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get miniprepDone =>
      boolean().withDefault(const Constant(false))();
  TextColumn get screeningNotes => text().nullable()();

  BoolColumn get insertSequenceVerified =>
      boolean().withDefault(const Constant(false))();
  TextColumn get sequencingPrimer => text().nullable()();
  TextColumn get additionalNotes => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}