import 'package:flutter/material.dart';

import '../../database/app_database.dart';
import '../records/experiment_form_page.dart';
import '../records/experiment_list_page.dart';

class HomePage extends StatelessWidget {
  final AppDatabase database;

  const HomePage({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    final modules = [
      'DNA Cloning',
      'Transformation',
      'Plasmid Prep',
      'Transfection',
      'Cell Selection',
      'siRNA Treatment',
      'Protein Purification',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Molecular Work App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '실험 모듈',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...modules.map(
            (module) => Card(
              child: ListTile(
                title: Text(module),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ExperimentFormPage(
                        database: database,
                        module: module,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ExperimentListPage(database: database),
                ),
              );
            },
            icon: const Icon(Icons.list_alt),
            label: const Text('저장된 기록 보기'),
          ),
        ],
      ),
    );
  }
}