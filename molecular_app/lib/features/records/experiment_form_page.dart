import 'package:flutter/material.dart';
import 'package:molecular_app/database/app_database.dart';

class ExperimentFormPage extends StatefulWidget {
  final AppDatabase database;
  final String module;

  const ExperimentFormPage({
    super.key,
    required this.database,
    required this.module,
  });

  @override
  State<ExperimentFormPage> createState() => _ExperimentFormPageState();
}

class _ExperimentFormPageState extends State<ExperimentFormPage> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title required')),
      );
      return;
    }

    final now = DateTime.now();

    await widget.database.createExperimentRecord(
      ExperimentRecordsCompanion.insert(
        title: title,
        module: widget.module,
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
        title: Text(widget.module),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Experiment title',
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