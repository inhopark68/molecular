import 'package:flutter/material.dart';

import '../../database/app_database.dart';

class SirnaFormPage extends StatefulWidget {
  final AppDatabase database;

  const SirnaFormPage({
    super.key,
    required this.database,
  });

  @override
  State<SirnaFormPage> createState() => _SirnaFormPageState();
}

class _SirnaFormPageState extends State<SirnaFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _targetGeneController = TextEditingController();
  final _sirnaNameController = TextEditingController();
  final _sequenceController = TextEditingController();
  final _concentrationController = TextEditingController();
  final _reagentController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _targetGeneController.dispose();
    _sirnaNameController.dispose();
    _sequenceController.dispose();
    _concentrationController.dispose();
    _reagentController.dispose();
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

      await widget.database.createExperimentRecord(
        ExperimentRecordsCompanion.insert(
          title: _titleController.text.trim(),
          module: 'siRNA Treatment',
          createdAt: now,
          updatedAt: now,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('siRNA record saved.')),
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
        title: const Text('siRNA Treatment'),
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
                controller: _targetGeneController,
                label: 'Target Gene',
              ),
              _buildTextField(
                controller: _sirnaNameController,
                label: 'siRNA Name',
              ),
              _buildTextField(
                controller: _sequenceController,
                label: 'Sequence',
                maxLines: 2,
              ),
              _buildTextField(
                controller: _concentrationController,
                label: 'Concentration',
              ),
              _buildTextField(
                controller: _reagentController,
                label: 'Transfection Reagent',
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