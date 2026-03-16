import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';

import '../../data/addgene/addgene_parser.dart';
import '../../data/database/app_database.dart';

class AddgeneImportPreviewDialog extends StatefulWidget {
  final AppDatabase db;
  final AddgenePlasmidImportData initialData;

  const AddgeneImportPreviewDialog({
    super.key,
    required this.db,
    required this.initialData,
  });

  @override
  State<AddgeneImportPreviewDialog> createState() =>
      _AddgeneImportPreviewDialogState();
}

class _AddgeneImportPreviewDialogState
    extends State<AddgeneImportPreviewDialog> {
  late final TextEditingController _plasmidNameController;
  late final TextEditingController _aliasController;
  late final TextEditingController _addgeneIdController;
  late final TextEditingController _backboneController;
  late final TextEditingController _insertGeneController;
  late final TextEditingController _promoterController;
  late final TextEditingController _tagController;
  late final TextEditingController _bacterialAntibioticController;
  late final TextEditingController _mammalianSelectionController;
  late final TextEditingController _oriController;
  late final TextEditingController _sizeBpController;
  late final TextEditingController _genbankUrlController;
  late final TextEditingController _snapgeneUrlController;
  late final TextEditingController _notesController;

  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();

    final d = widget.initialData;

    _plasmidNameController = TextEditingController(text: d.plasmidName);
    _aliasController = TextEditingController(text: d.alias ?? '');
    _addgeneIdController = TextEditingController(text: d.addgeneId ?? '');
    _backboneController = TextEditingController(text: d.backbone ?? '');
    _insertGeneController = TextEditingController(text: d.insertGene ?? '');
    _promoterController = TextEditingController(text: d.promoter ?? '');
    _tagController = TextEditingController(text: d.tag ?? '');
    _bacterialAntibioticController =
        TextEditingController(text: d.bacterialAntibiotic ?? '');
    _mammalianSelectionController =
        TextEditingController(text: d.mammalianSelection ?? '');
    _oriController = TextEditingController(text: d.ori ?? '');
    _sizeBpController =
        TextEditingController(text: d.sizeBp?.toString() ?? '');
    _genbankUrlController = TextEditingController(text: d.genbankUrl ?? '');
    _snapgeneUrlController = TextEditingController(text: d.snapgeneUrl ?? '');
    _notesController = TextEditingController(text: d.notes ?? '');
  }

  @override
  void dispose() {
    _plasmidNameController.dispose();
    _aliasController.dispose();
    _addgeneIdController.dispose();
    _backboneController.dispose();
    _insertGeneController.dispose();
    _promoterController.dispose();
    _tagController.dispose();
    _bacterialAntibioticController.dispose();
    _mammalianSelectionController.dispose();
    _oriController.dispose();
    _sizeBpController.dispose();
    _genbankUrlController.dispose();
    _snapgeneUrlController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String? _nullableText(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  int? _nullableInt(TextEditingController controller) {
    final value = controller.text.trim();
    if (value.isEmpty) return null;
    return int.tryParse(value);
  }

  Future<void> _save() async {
    final plasmidName = _plasmidNameController.text.trim();

    if (plasmidName.isEmpty) {
      setState(() {
        _error = 'Plasmid name is required.';
      });
      return;
    }

    final sizeBpText = _sizeBpController.text.trim();
    if (sizeBpText.isNotEmpty && int.tryParse(sizeBpText) == null) {
      setState(() {
        _error = 'Size (bp) must be a number.';
      });
      return;
    }

    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      final plasmidId = await widget.db.importAddgenePlasmid(
        AddgenePlasmidImportData(
          plasmidName: plasmidName,
          alias: _nullableText(_aliasController),
          addgeneId: _nullableText(_addgeneIdController),
          backbone: _nullableText(_backboneController),
          insertGene: _nullableText(_insertGeneController),
          promoter: _nullableText(_promoterController),
          tag: _nullableText(_tagController),
          bacterialAntibiotic: _nullableText(_bacterialAntibioticController),
          mammalianSelection: _nullableText(_mammalianSelectionController),
          ori: _nullableText(_oriController),
          sizeBp: _nullableInt(_sizeBpController),
          genbankUrl: _nullableText(_genbankUrlController),
          snapgeneUrl: _nullableText(_snapgeneUrlController),
          notes: _nullableText(_notesController),
        ),
      );

      if (!mounted) return;
      Navigator.of(context).pop(plasmidId);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
    }
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Review Addgene plasmid import'),
      content: SizedBox(
        width: 760,
        height: 620,
        child: Column(
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _field('Plasmid name *', _plasmidNameController),
                    _field('Alias', _aliasController),
                    _field('Addgene ID', _addgeneIdController),
                    _field('Backbone', _backboneController),
                    _field('Insert gene', _insertGeneController),
                    _field('Promoter', _promoterController),
                    _field('Tag', _tagController),
                    _field(
                      'Bacterial antibiotic',
                      _bacterialAntibioticController,
                    ),
                    _field(
                      'Mammalian selection',
                      _mammalianSelectionController,
                    ),
                    _field('Ori', _oriController),
                    _field(
                      'Size (bp)',
                      _sizeBpController,
                      keyboardType: TextInputType.number,
                    ),
                    _field('GenBank URL', _genbankUrlController),
                    _field('SnapGene URL', _snapgeneUrlController),
                    _field('Notes', _notesController, maxLines: 3),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _isSaving ? null : _save,
          icon: const Icon(Icons.save),
          label: Text(_isSaving ? 'Saving...' : 'Save to Inventory'),
        ),
      ],
    );
  }
}