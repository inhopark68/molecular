import 'package:flutter/material.dart';

import 'package:molecular_app/database/app_database.dart';
import 'package:molecular_app/features/records/cloning_form_page.dart';
import 'package:molecular_app/features/records/purification_form_page.dart';
import 'package:molecular_app/features/records/sirna_form_page.dart';
import 'package:molecular_app/features/records/transfection_form_page.dart';

class ExperimentDetailPage extends StatelessWidget {
  final AppDatabase database;
  final int experimentId;

  const ExperimentDetailPage({
    super.key,
    required this.database,
    required int recordId,
  }) : experimentId = recordId;

  Widget _section(BuildContext context, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(value.isEmpty ? '-' : value),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? value) {
    if (value == null) return '-';

    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }

  Future<void> _openEditPage(
    BuildContext context,
    ExperimentRecord record,
  ) async {
    Widget? page;

    switch (record.module) {
      case 'DNA Cloning':
        page = CloningFormPage(database: database);
        break;
      case 'Transfection':
        page = TransfectionFormPage(database: database);
        break;
      case 'siRNA Treatment':
        page = SirnaFormPage(database: database);
        break;
      case 'Protein Purification':
        page = PurificationFormPage(database: database);
        break;
      default:
        page = null;
    }

    if (page == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Edit page is not available for "${record.module}".'),
        ),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page!),
    );
  }

  Future<void> _deleteRecord(
    BuildContext context,
    ExperimentRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Record'),
        content: Text('Are you sure you want to delete "${record.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await database.deleteExperimentRecord(record.id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${record.title}" deleted.')),
    );

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ExperimentRecord?>(
      stream: database.watchExperimentRecordById(experimentId),
      builder: (context, snapshot) {
        final record = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Experiment Detail'),
            actions: record == null
                ? null
                : [
                    IconButton(
                      tooltip: 'Edit',
                      onPressed: () => _openEditPage(context, record),
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      tooltip: 'Delete',
                      onPressed: () => _deleteRecord(context, record),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
          ),
          body: Builder(
            builder: (context) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Failed to load experiment record.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (record == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Experiment record not found.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            child: Icon(Icons.science_outlined),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  record.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  record.module,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _section(context, 'Record ID', record.id.toString()),
                  _section(context, 'Title', record.title),
                  _section(context, 'Module', record.module),
                  _section(
                    context,
                    'Created At',
                    _formatDateTime(record.createdAt),
                  ),
                  _section(
                    context,
                    'Updated At',
                    _formatDateTime(record.updatedAt),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}