import 'package:flutter/material.dart';

import '../../database/app_database.dart';
import 'package:drift/drift.dart' show Value;

class PurificationFormPage extends StatefulWidget {
  final AppDatabase database;

  const PurificationFormPage({
    super.key,
    required this.database,
  });

  @override
  State<PurificationFormPage> createState() => _PurificationFormPageState();
}

class _PurificationFormPageState extends State<PurificationFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _sampleNameController = TextEditingController();
  final _methodController = TextEditingController();
  final _bufferController = TextEditingController();
  final _elutionController = TextEditingController();
  final _yieldController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _sampleNameController.dispose();
    _methodController.dispose();
    _bufferController.dispose();
    _elutionController.dispose();
    _yieldController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final now = DateTime.now();

      final experiment = ExperimentRecordsCompanion(
        title: Value(_titleController.text.trim()),
        module: const Value('Cloning'),
        createdAt: Value(now),
        updatedAt: Value(now),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Purification record saved.')),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save record: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protein Purification'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildTextField(
                controller: _titleController,
                label: 'Experiment Title',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Experiment title is required.';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _sampleNameController,
                label: 'Sample Name',
              ),
              _buildTextField(
                controller: _methodController,
                label: 'Purification Method',
              ),
              _buildTextField(
                controller: _bufferController,
                label: 'Buffer Composition',
                maxLines: 2,
              ),
              _buildTextField(
                controller: _elutionController,
                label: 'Elution Condition',
              ),
              _buildTextField(
                controller: _yieldController,
                label: 'Yield Amount',
              ),
              _buildTextField(
                controller: _notesController,
                label: 'Notes',
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _isSaving ? null : _save,
                child: Text(_isSaving ? 'Saving...' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}