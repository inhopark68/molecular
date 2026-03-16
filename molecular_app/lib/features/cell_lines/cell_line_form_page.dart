import 'package:flutter/material.dart';
import 'package:molecular_app/database/app_database.dart';

class CellLineFormPage extends StatefulWidget {
  final AppDatabase database;

  const CellLineFormPage({
    super.key,
    required this.database,
  });

  @override
  State<CellLineFormPage> createState() => _CellLineFormPageState();
}

class _CellLineFormPageState extends State<CellLineFormPage> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) return;

    final now = DateTime.now();

    await widget.database.createCellLine(
      CellLinesCompanion.insert(
        cellLineName: name,
        createdAt: now,
        updatedAt: now,
      ),
    );

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cell Line'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Cell line',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}