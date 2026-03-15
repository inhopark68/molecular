import 'package:flutter/material.dart';

import '../../database/app_database.dart';
import 'experiment_detail_page.dart';

class ExperimentListPage extends StatelessWidget {
  final AppDatabase database;

  const ExperimentListPage({
    super.key,
    required this.database,
  });

  Future<void> _delete(BuildContext context, int id) async {
    await database.deleteExperimentRecordById(id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('기록이 삭제되었습니다.')),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('저장된 실험 기록'),
      ),
      body: StreamBuilder<List<ExperimentRecord>>(
        stream: database.watchAllExperimentRecords(),
        builder: (context, snapshot) {
          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Text('저장된 기록이 없습니다.'),
            );
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                title: Text(item.title),
                subtitle: Text(
                  '${item.module} · ${item.sampleId ?? 'No Sample ID'}',
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ExperimentDetailPage(
                        database: database,
                        recordId: item.id,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _confirmDelete(context, item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}