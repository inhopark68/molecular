import 'package:flutter/material.dart';

import '../../database/app_database.dart';
import 'plasmid_form_page.dart';

class PlasmidDetailPage extends StatelessWidget {
  final AppDatabase database;
  final int plasmidId;

  const PlasmidDetailPage({
    super.key,
    required this.database,
    required this.plasmidId,
  });

  Future<void> _openEditPage(BuildContext context, Plasmid plasmid) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlasmidFormPage(
          database: database,
          initialPlasmid: plasmid,
        ),
      ),
    );
  }

  Future<void> _deletePlasmid(BuildContext context, Plasmid plasmid) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Plasmid'),
        content: Text('Are you sure you want to delete "${plasmid.name}"?'),
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

    await database.deletePlasmid(plasmid.id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${plasmid.name}" deleted.')),
    );

    Navigator.of(context).pop(true);
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required String? value,
    int maxLines = 10,
  }) {
    final displayValue =
        (value == null || value.trim().isEmpty) ? 'Not provided' : value.trim();

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
            Text(
              displayValue,
              maxLines: maxLines,
              overflow: maxLines == 1 ? TextOverflow.ellipsis : null,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? value) {
    if (value == null) return 'Not available';

    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Plasmid?>(
      stream: database.watchPlasmidById(plasmidId),
      builder: (context, snapshot) {
        final plasmid = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Plasmid Detail'),
            actions: plasmid == null
                ? null
                : [
                    IconButton(
                      tooltip: 'Edit',
                      onPressed: () => _openEditPage(context, plasmid),
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      tooltip: 'Delete',
                      onPressed: () => _deletePlasmid(context, plasmid),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
          ),
          body: Builder(
            builder: (context) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'Failed to load plasmid details.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (plasmid == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'Plasmid not found.',
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
                            child: Icon(Icons.biotech_outlined),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plasmid.name,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  plasmid.alias?.trim().isNotEmpty == true
                                      ? plasmid.alias!.trim()
                                      : 'No alias',
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
                  _buildSectionCard(
                    context: context,
                    title: 'Backbone',
                    value: plasmid.backbone,
                    maxLines: 3,
                  ),
                  _buildSectionCard(
                    context: context,
                    title: 'Insert Gene',
                    value: plasmid.insertGene,
                    maxLines: 3,
                  ),
                  _buildSectionCard(
                    context: context,
                    title: 'Antibiotic Resistance',
                    value: plasmid.antibioticResistance,
                    maxLines: 3,
                  ),
                  _buildSectionCard(
                    context: context,
                    title: 'Description',
                    value: plasmid.description,
                  ),
                  _buildSectionCard(
                    context: context,
                    title: 'Notes',
                    value: plasmid.notes,
                  ),
                  _buildSectionCard(
                    context: context,
                    title: 'Last Updated',
                    value: _formatDateTime(plasmid.updatedAt),
                    maxLines: 1,
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