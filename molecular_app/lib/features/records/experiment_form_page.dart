import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../../database/app_database.dart';

class ExperimentFormPage extends StatefulWidget {
  final AppDatabase database;
  final String module;
  final ExperimentRecord? initialRecord;

  const ExperimentFormPage({
    super.key,
    required this.database,
    required this.module,
    this.initialRecord,
  });

  bool get isEditMode => initialRecord != null;

  @override
  State<ExperimentFormPage> createState() => _ExperimentFormPageState();
}

class _ExperimentFormPageState extends State<ExperimentFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _objectiveController;
  late final TextEditingController _sampleIdController;
  late final TextEditingController _notesController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    final record = widget.initialRecord;

    _titleController = TextEditingController(text: record?.title ?? '');
    _objectiveController =
        TextEditingController(text: record?.objective ?? '');
    _sampleIdController =
        TextEditingController(text: record?.sampleId ?? '');
    _notesController = TextEditingController(text: record?.notes ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _objectiveController.dispose();
    _sampleIdController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final now = DateTime.now();

    if (widget.isEditMode) {
      final old = widget.initialRecord!;

      final updated = old.copyWith(
        module: widget.module,
        title: _titleController.text.trim(),
        objective: drift.Value(
          _objectiveController.text.trim().isEmpty
              ? null
              : _objectiveController.text.trim(),
        ),
        sampleId: drift.Value(
          _sampleIdController.text.trim().isEmpty
              ? null
              : _sampleIdController.text.trim(),
        ),
        notes: drift.Value(
          _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        ),
        updatedAt: now,
      );

      await widget.database.updateExperimentRecord(updated);
    } else {
      await widget.database.createExperimentRecord(
        ExperimentRecordsCompanion.insert(
          module: widget.module,
          title: _titleController.text.trim(),
          objective: drift.Value(
            _objectiveController.text.trim().isEmpty
                ? null
                : _objectiveController.text.trim(),
          ),
          sampleId: drift.Value(
            _sampleIdController.text.trim().isEmpty
                ? null
                : _sampleIdController.text.trim(),
          ),
          notes: drift.Value(
            _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
          ),
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    if (!mounted) return;

    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.isEditMode ? '기록이 수정되었습니다.' : '기록이 저장되었습니다.'),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEditMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '${widget.module} 기록 수정' : '${widget.module} 기록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                widget.module,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '실험 제목',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '실험 제목을 입력하세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _objectiveController,
                decoration: const InputDecoration(
                  labelText: '목적',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sampleIdController,
                decoration: const InputDecoration(
                  labelText: 'Sample ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: '비고',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _isSaving ? null : _save,
                child: Text(
                  _isSaving
                      ? (isEdit ? '수정 중...' : '저장 중...')
                      : (isEdit ? '수정 완료' : '저장'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}