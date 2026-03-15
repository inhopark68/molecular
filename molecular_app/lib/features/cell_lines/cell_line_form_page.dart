import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';

import '../../../database/app_database.dart';

class CellLineFormPage extends StatefulWidget {
  final AppDatabase database;
  final CellLine? initialCellLine;

  const CellLineFormPage({
    super.key,
    required this.database,
    this.initialCellLine,
  });

  @override
  State<CellLineFormPage> createState() => _CellLineFormPageState();
}

class _CellLineFormPageState extends State<CellLineFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _aliasController;
  late final TextEditingController _speciesController;
  late final TextEditingController _tissueController;
  late final TextEditingController _growthConditionController;
  late final TextEditingController _cultureMediumController;
  late final TextEditingController _selectionMarkerController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _notesController;

  bool get _isEdit => widget.initialCellLine != null;

  @override
  void initState() {
    super.initState();

    final cellLine = widget.initialCellLine;

    _nameController = TextEditingController(text: cellLine?.name ?? '');
    _aliasController = TextEditingController(text: cellLine?.alias ?? '');
    _speciesController = TextEditingController(text: cellLine?.species ?? '');
    _tissueController = TextEditingController(text: cellLine?.tissue ?? '');
    _growthConditionController =
        TextEditingController(text: cellLine?.growthCondition ?? '');
    _cultureMediumController =
        TextEditingController(text: cellLine?.cultureMedium ?? '');
    _selectionMarkerController =
        TextEditingController(text: cellLine?.selectionMarker ?? '');
    _descriptionController =
        TextEditingController(text: cellLine?.description ?? '');
    _notesController = TextEditingController(text: cellLine?.notes ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aliasController.dispose();
    _speciesController.dispose();
    _tissueController.dispose();
    _growthConditionController.dispose();
    _cultureMediumController.dispose();
    _selectionMarkerController.dispose();
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
      final current = widget.initialCellLine!;

      final updated = current.copyWith(
        name: _nameController.text.trim(),
        alias: Value(_emptyToNull(_aliasController.text)),
        species: Value(_emptyToNull(_speciesController.text)),
        tissue: Value(_emptyToNull(_tissueController.text)),
        growthCondition: Value(_emptyToNull(_growthConditionController.text)),
        cultureMedium: Value(_emptyToNull(_cultureMediumController.text)),
        selectionMarker: Value(_emptyToNull(_selectionMarkerController.text)),
        description: Value(_emptyToNull(_descriptionController.text)),
        notes: Value(_emptyToNull(_notesController.text)),
        updatedAt: now,
      );

      await widget.database.updateCellLine(updated);
    } else {
      await widget.database.createCellLine(
        CellLinesCompanion.insert(
          name: _nameController.text.trim(),
          alias: Value(_emptyToNull(_aliasController.text)),
          species: Value(_emptyToNull(_speciesController.text)),
          tissue: Value(_emptyToNull(_tissueController.text)),
          growthCondition: Value(_emptyToNull(_growthConditionController.text)),
          cultureMedium: Value(_emptyToNull(_cultureMediumController.text)),
          selectionMarker: Value(_emptyToNull(_selectionMarkerController.text)),
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
        title: Text(_isEdit ? 'Edit Cell Line' : 'Add Cell Line'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Cell Line Name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Cell line name is required.';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _aliasController,
                label: 'Alias',
              ),
              _buildTextField(
                controller: _speciesController,
                label: 'Species',
              ),
              _buildTextField(
                controller: _tissueController,
                label: 'Tissue',
              ),
              _buildTextField(
                controller: _growthConditionController,
                label: 'Growth Condition',
              ),
              _buildTextField(
                controller: _cultureMediumController,
                label: 'Culture Medium',
              ),
              _buildTextField(
                controller: _selectionMarkerController,
                label: 'Selection Marker',
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
                child: Text(_isEdit ? 'Update Cell Line' : 'Save Cell Line'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}