import 'package:flutter/material.dart';

import '../../database/app_database.dart';
import 'experiment_form_page.dart';

class ExperimentDetailPage extends StatelessWidget {
  final AppDatabase database;
  final int recordId;

  const ExperimentDetailPage({
    super.key,
    required this.database,
    required this.recordId,
  });

  Future<void> _delete(BuildContext context, int id) async {
    await database.deleteExperimentRecordById(id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('기록이 삭제되었습니다.')),
    );

    Navigator.of(context).pop();
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ExperimentRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('기록 삭제'),
            content: Text('"${record.title}" 기록을 삭제할까요?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('삭제'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) return;
    await _delete(context, record.id);
  }

  String _formatDate(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    final h = dateTime.hour.toString().padLeft(2, '0');
    final min = dateTime.minute.toString().padLeft(2, '0');
    return '$y-$m-$d $h:$min';
  }

  Widget _section(String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(value.isEmpty ? '-' : value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ExperimentRecord?>(
      stream: database.watchExperimentRecordById(recordId),
      builder: (context, snapshot) {
        final record = snapshot.data;

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (record == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('기록 상세')),
            body: const Center(
              child: Text('기록을 찾을 수 없습니다.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('기록 상세'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ExperimentFormPage(
                        database: database,
                        module: record.module,
                        initialRecord: record,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () => _confirmDelete(context, record),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                record.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                record.module,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              _section('목적', record.objective ?? ''),
              _section('Sample ID', record.sampleId ?? ''),
              _section('비고', record.notes ?? ''),
              _section('생성 시각', _formatDate(record.createdAt)),
              _section('수정 시각', _formatDate(record.updatedAt)),
            ],
          ),
        );
      },
    );
  }
}