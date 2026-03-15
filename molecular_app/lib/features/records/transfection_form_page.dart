import 'package:flutter/material.dart';
import 'package:molecular_work_app/database/app_database.dart';

class TransfectionFormPage extends StatefulWidget {
  final AppDatabase database;

  const TransfectionFormPage({
    super.key,
    required this.database,
  });

  @override
  State<TransfectionFormPage> createState() => _TransfectionFormPageState();
}

class _TransfectionFormPageState extends State<TransfectionFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _cellLineController = TextEditingController();
  final _materialController = TextEditingController();
  final _reagentController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _cellLineController.dispose();
    _materialController.dispose();
    _reagentController.dispose();
    _amountController.dispose();
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
          module: 'Transfection',
          createdAt: now,
          updatedAt: now,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transfection record saved.')),
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
        title: const Text('Transfection'),
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
                controller: _cellLineController,
                label: 'Cell Line',
              ),
              _buildTextField(
                controller: _materialController,
                label: 'DNA / RNA / Plasmid',
              ),
              _buildTextField(
                controller: _reagentController,
                label: 'Transfection Reagent',
              ),
              _buildTextField(
                controller: _amountController,
                label: 'Amount / Ratio',
              ),
              _buildTextField(
                controller: _notesController,
                label: 'Notes',
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSaving ? null : _save,
                  child: Text(_isSaving ? 'Saving...' : 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}