import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';

import '../../database/app_database.dart';

class PlasmidFormPage extends StatefulWidget {
  final AppDatabase database;
  final Plasmid? initialPlasmid;

  const PlasmidFormPage({
    super.key,
    required this.database,
    this.initialPlasmid,
  });

  @override
  State<PlasmidFormPage> createState() => _PlasmidFormPageState();
}

class _PlasmidFormPageState extends State<PlasmidFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _aliasController;
  late final TextEditingController _backboneController;
  late final TextEditingController _insertGeneController;
  late final TextEditingController _antibioticResistanceController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;

  bool get _isEdit => widget.initialPlasmid != null;

  @override
  void initState() {
    super.initState();

    final plasmid = widget.initialPlasmid;

    _nameController = TextEditingController(text: plasmid?.name ?? '');
    _aliasController = TextEditingController(text: plasmid?.alias ?? '');
    _backboneController = TextEditingController(text: plasmid?.backbone ?? '');
    _insertGeneController =
        TextEditingController(text: plasmid?.insertGene ?? '');
    _antibioticResistanceController =
        TextEditingController(text: plasmid?.antibioticResistance ?? '');
    _descriptionController =
        TextEditingController(text: plasmid?.description ?? '');
    _notesController = TextEditingController(text: plasmid?.notes ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aliasController.dispose();
    _backboneController.dispose();
    _insertGeneController.dispose();
    _antibioticResistanceController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
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
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();

    if (_isEdit) {
      final current = widget.initialPlasmid!;

      final updated = current.copyWith(
        name: _nameController.text.trim(),
        alias: Value(_emptyToNull(_aliasController.text)),
        backbone: Value(_emptyToNull(_backboneController.text)),
        insertGene: Value(_emptyToNull(_insertGeneController.text)),
        antibioticResistance:
            Value(_emptyToNull(_antibioticResistanceController.text)),
        description: Value(_emptyToNull(_descriptionController.text)),
        notes: Value(_emptyToNull(_notesController.text)),
        updatedAt: now,
      );

      await widget.database.updatePlasmid(updated);
    } else {
      await widget.database.createPlasmid(
        PlasmidsCompanion.insert(
          name: _nameController.text.trim(),
          alias: Value(_emptyToNull(_aliasController.text)),
          backbone: Value(_emptyToNull(_backboneController.text)),
          insertGene: Value(_emptyToNull(_insertGeneController.text)),
          antibioticResistance:
              Value(_emptyToNull(_antibioticResistanceController.text)),
          description: Value(_emptyToNull(_descriptionController.text)),
          notes: Value(_emptyToNull(_notesController.text)),
          updatedAt: Value(now),
        ),
      );
    }

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Plasmid' : 'Add Plasmid'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Plasmid Name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Plasmid name is required.';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _aliasController,
                label: 'Alias',
              ),
              _buildTextField(
                controller: _backboneController,
                label: 'Backbone',
              ),
              _buildTextField(
                controller: _insertGeneController,
                label: 'Insert Gene',
              ),
              _buildTextField(
                controller: _antibioticResistanceController,
                label: 'Antibiotic Resistance',
              ),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 3,
              ),
              _buildTextField(
                controller: _notesController,
                label: 'Notes',
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _save,
                child: Text(_isEdit ? 'Update Plasmid' : 'Save Plasmid'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}