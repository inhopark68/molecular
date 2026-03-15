import 'package:flutter/material.dart';
import 'package:molecular_work_app/database/app_database.dart';
import 'package:molecular_work_app/features/cell_lines/cell_line_form_page.dart';

class CloningFormPage extends StatelessWidget {
  final AppDatabase database;

  const CloningFormPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DNA Cloning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              'DNA Cloning',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '여기에 cloning 관련 입력 폼을 추가하면 됩니다.',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CellLineFormPage(database: database),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Cell Line'),
            ),
          ],
        ),
      ),
    );
  }
}