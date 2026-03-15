import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/experiment_records.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ExperimentRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(
          executor ??
              driftDatabase(
                name: 'molecular_app_db',
              ),
        );

  @override
  int get schemaVersion => 1;

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

  Stream<ExperimentRecord?> watchExperimentRecordById(int id) {
    return (select(experimentRecords)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<bool> updateExperimentRecord(ExperimentRecord record) {
    return update(experimentRecords).replace(record);
  }

  Future<int> deleteExperimentRecordById(int id) {
    return (delete(experimentRecords)..where((t) => t.id.equals(id))).go();
  }
}