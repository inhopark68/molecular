import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/cell_lines.dart';
import 'tables/cloning_details.dart';
import 'tables/experiment_records.dart';
import 'tables/plasmids.dart';
import 'tables/purification_details.dart';
import 'tables/sirna_details.dart';
import 'tables/transfection_details.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'molecular_app_db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    ExperimentRecords,
    CloningDetails,
    TransfectionDetails,
    SirnaDetails,
    PurificationDetails,
    Plasmids,
    CellLines,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(cloningDetails);
          }
          if (from < 3) {
            await m.createTable(transfectionDetails);
          }
          if (from < 4) {
            await m.createTable(sirnaDetails);
          }
          if (from < 5) {
            await m.createTable(purificationDetails);
          }
          if (from < 6) {
            await m.createTable(plasmids);
          }
          if (from < 7) {
            await m.createTable(cellLines);
          }
        },
      );

  // ---------------------------------------------------------------------------
  // Base experiment records
  // ---------------------------------------------------------------------------

  Future<int> createExperimentRecord(ExperimentRecordsCompanion entry) {
    return into(experimentRecords).insert(entry);
  }

  Future<List<ExperimentRecord>> getAllExperimentRecords() {
    return (select(experimentRecords)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  Stream<List<ExperimentRecord>> watchAllExperimentRecords() {
    return (select(experimentRecords)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  Future<ExperimentRecord?> getExperimentRecordById(int id) {
    return (select(experimentRecords)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<ExperimentRecord?> watchExperimentRecordById(int id) {
    return (select(experimentRecords)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<bool> updateExperimentRecord(ExperimentRecord record) {
    return update(experimentRecords).replace(record);
  }

  Future<int> deleteExperimentRecordById(int id) async {
    return transaction(() async {
      await (delete(cloningDetails)
            ..where((t) => t.experimentRecordId.equals(id)))
          .go();

      await (delete(transfectionDetails)
            ..where((t) => t.experimentRecordId.equals(id)))
          .go();

      await (delete(sirnaDetails)
            ..where((t) => t.experimentRecordId.equals(id)))
          .go();

      await (delete(purificationDetails)
            ..where((t) => t.experimentRecordId.equals(id)))
          .go();

      return (delete(experimentRecords)..where((t) => t.id.equals(id))).go();
    });
  }

  Future<int> deleteExperimentRecord(int id) {
    return deleteExperimentRecordById(id);
  }

  // ---------------------------------------------------------------------------
  // DNA Cloning
  // ---------------------------------------------------------------------------

  Future<int> createCloningExperiment({
    required ExperimentRecordsCompanion experiment,
    required CloningDetailsCompanion cloning,
  }) async {
    return transaction(() async {
      final experimentId = await into(experimentRecords).insert(experiment);

      await into(cloningDetails).insert(
        cloning.copyWith(
          experimentRecordId: Value(experimentId),
        ),
      );

      return experimentId;
    });
  }

  Future<int> createCloningRecord({
    required ExperimentRecordsCompanion experiment,
    required CloningDetailsCompanion cloning,
  }) {
    return createCloningExperiment(
      experiment: experiment,
      cloning: cloning,
    );
  }

  Future<CloningDetail?> getCloningDetailByExperimentId(int experimentId) {
    return (select(cloningDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .getSingleOrNull();
  }

  Stream<CloningDetail?> watchCloningDetailByExperimentId(int experimentId) {
    return (select(cloningDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .watchSingleOrNull();
  }

  Future<bool> updateCloningDetail(CloningDetail detail) {
    return update(cloningDetails).replace(detail);
  }

  Future<void> updateCloningExperiment({
    required ExperimentRecord experiment,
    required CloningDetail detail,
  }) async {
    await transaction(() async {
      await update(experimentRecords).replace(experiment);
      await update(cloningDetails).replace(detail);
    });
  }

  Future<void> updateCloningRecord({
    required ExperimentRecord experiment,
    required CloningDetail detail,
  }) {
    return updateCloningExperiment(
      experiment: experiment,
      detail: detail,
    );
  }

  // ---------------------------------------------------------------------------
  // Transfection
  // ---------------------------------------------------------------------------

  Future<int> createTransfectionExperiment({
    required ExperimentRecordsCompanion experiment,
    required TransfectionDetailsCompanion transfection,
  }) async {
    return transaction(() async {
      final experimentId = await into(experimentRecords).insert(experiment);

      await into(transfectionDetails).insert(
        transfection.copyWith(
          experimentRecordId: Value(experimentId),
        ),
      );

      return experimentId;
    });
  }

  Future<int> createTransfectionRecord({
    required ExperimentRecordsCompanion experiment,
    required TransfectionDetailsCompanion transfection,
  }) {
    return createTransfectionExperiment(
      experiment: experiment,
      transfection: transfection,
    );
  }

  Future<TransfectionDetail?> getTransfectionDetailByExperimentId(
    int experimentId,
  ) {
    return (select(transfectionDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .getSingleOrNull();
  }

  Stream<TransfectionDetail?> watchTransfectionDetailByExperimentId(
    int experimentId,
  ) {
    return (select(transfectionDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .watchSingleOrNull();
  }

  Future<bool> updateTransfectionDetail(TransfectionDetail detail) {
    return update(transfectionDetails).replace(detail);
  }

  Future<void> updateTransfectionExperiment({
    required ExperimentRecord experiment,
    required TransfectionDetail detail,
  }) async {
    await transaction(() async {
      await update(experimentRecords).replace(experiment);
      await update(transfectionDetails).replace(detail);
    });
  }

  Future<void> updateTransfectionRecord({
    required ExperimentRecord experiment,
    required TransfectionDetail detail,
  }) {
    return updateTransfectionExperiment(
      experiment: experiment,
      detail: detail,
    );
  }

  // ---------------------------------------------------------------------------
  // siRNA
  // ---------------------------------------------------------------------------

  Future<int> createSirnaExperiment({
    required ExperimentRecordsCompanion experiment,
    required SirnaDetailsCompanion sirna,
  }) async {
    return transaction(() async {
      final experimentId = await into(experimentRecords).insert(experiment);

      await into(sirnaDetails).insert(
        sirna.copyWith(
          experimentRecordId: Value(experimentId),
        ),
      );

      return experimentId;
    });
  }

  Future<int> createSirnaRecord({
    required ExperimentRecordsCompanion experiment,
    required SirnaDetailsCompanion sirna,
  }) {
    return createSirnaExperiment(
      experiment: experiment,
      sirna: sirna,
    );
  }

  Future<SirnaDetail?> getSirnaDetailByExperimentId(int experimentId) {
    return (select(sirnaDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .getSingleOrNull();
  }

  Stream<SirnaDetail?> watchSirnaDetailByExperimentId(int experimentId) {
    return (select(sirnaDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .watchSingleOrNull();
  }

  Future<bool> updateSirnaDetail(SirnaDetail detail) {
    return update(sirnaDetails).replace(detail);
  }

  Future<void> updateSirnaExperiment({
    required ExperimentRecord experiment,
    required SirnaDetail detail,
  }) async {
    await transaction(() async {
      await update(experimentRecords).replace(experiment);
      await update(sirnaDetails).replace(detail);
    });
  }

  Future<void> updateSirnaRecord({
    required ExperimentRecord experiment,
    required SirnaDetail detail,
  }) {
    return updateSirnaExperiment(
      experiment: experiment,
      detail: detail,
    );
  }

  // ---------------------------------------------------------------------------
  // Protein Purification
  // ---------------------------------------------------------------------------

  Future<int> createPurificationExperiment({
    required ExperimentRecordsCompanion experiment,
    required PurificationDetailsCompanion purification,
  }) async {
    return transaction(() async {
      final experimentId = await into(experimentRecords).insert(experiment);

      await into(purificationDetails).insert(
        purification.copyWith(
          experimentRecordId: Value(experimentId),
        ),
      );

      return experimentId;
    });
  }

  Future<int> createPurificationRecord({
    required ExperimentRecordsCompanion experiment,
    required PurificationDetailsCompanion purification,
  }) {
    return createPurificationExperiment(
      experiment: experiment,
      purification: purification,
    );
  }

  Future<PurificationDetail?> getPurificationDetailByExperimentId(
    int experimentId,
  ) {
    return (select(purificationDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .getSingleOrNull();
  }

  Stream<PurificationDetail?> watchPurificationDetailByExperimentId(
    int experimentId,
  ) {
    return (select(purificationDetails)
          ..where((t) => t.experimentRecordId.equals(experimentId)))
        .watchSingleOrNull();
  }

  Future<bool> updatePurificationDetail(PurificationDetail detail) {
    return update(purificationDetails).replace(detail);
  }

  Future<void> updatePurificationExperiment({
    required ExperimentRecord experiment,
    required PurificationDetail detail,
  }) async {
    await transaction(() async {
      await update(experimentRecords).replace(experiment);
      await update(purificationDetails).replace(detail);
    });
  }

  Future<void> updatePurificationRecord({
    required ExperimentRecord experiment,
    required PurificationDetail detail,
  }) {
    return updatePurificationExperiment(
      experiment: experiment,
      detail: detail,
    );
  }

  // ---------------------------------------------------------------------------
  // Plasmid inventory
  // ---------------------------------------------------------------------------

  Future<int> createPlasmid(PlasmidsCompanion entry) {
    return into(plasmids).insert(entry);
  }

  Future<List<Plasmid>> getAllPlasmids() {
    return (select(plasmids)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.updatedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  Stream<List<Plasmid>> watchAllPlasmids() {
    return (select(plasmids)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.updatedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  Future<Plasmid?> getPlasmidById(int id) {
    return (select(plasmids)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<Plasmid?> watchPlasmidById(int id) {
    return (select(plasmids)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<bool> updatePlasmid(Plasmid plasmid) {
    return update(plasmids).replace(plasmid);
  }

  Future<int> deletePlasmidById(int id) {
    return (delete(plasmids)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deletePlasmid(int id) {
    return deletePlasmidById(id);
  }

  // ---------------------------------------------------------------------------
  // Cell line inventory
  // ---------------------------------------------------------------------------

  Future<int> createCellLine(CellLinesCompanion entry) {
    return into(cellLines).insert(entry);
  }

  Future<List<CellLine>> getAllCellLines() {
    return (select(cellLines)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.updatedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
  }

  Stream<List<CellLine>> watchAllCellLines() {
    return (select(cellLines)
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.updatedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  Future<CellLine?> getCellLineById(int id) {
    return (select(cellLines)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<CellLine?> watchCellLineById(int id) {
    return (select(cellLines)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<bool> updateCellLine(CellLine cellLine) {
    return update(cellLines).replace(cellLine);
  }

  Future<int> deleteCellLineById(int id) {
    return (delete(cellLines)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteCellLine(int id) {
    return deleteCellLineById(id);
  }
}