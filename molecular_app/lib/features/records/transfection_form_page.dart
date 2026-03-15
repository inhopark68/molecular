import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../../database/app_database.dart';

class TransfectionFormPage extends StatefulWidget {
  final AppDatabase database;
  final ExperimentRecord? initialRecord;
  final TransfectionDetail? initialDetail;

  const TransfectionFormPage({
    super.key,
    required this.database,
    this.initialRecord,
    this.initialDetail,
  });

  bool get isEditMode => initialRecord != null && initialDetail != null;

  @override
  State<TransfectionFormPage> createState() => _TransfectionFormPageState();
}

class _TransfectionFormPageState extends State<TransfectionFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _objectiveController;
  late final TextEditingController _sampleIdController;
  late final TextEditingController _notesController;

  late final TextEditingController _cellLineController;
  late final TextEditingController _passageNumberController;
  late final TextEditingController _transfectionReagentController;
  late final TextEditingController _nucleicAcidTypeController;
  late final TextEditingController _nucleicAcidIdController;
  late final TextEditingController _plateFormatController;
  late final TextEditingController _observationTimepointController;
  late final TextEditingController _transfectionEfficiencyController;
  late final TextEditingController _toxicityObservationController;
  late final TextEditingController _endpointResultController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    final record = widget.initialRecord;
    final detail = widget.initialDetail;

    _titleController = TextEditingController(text: record?.title ?? '');
    _objectiveController = TextEditingController(text: record?.objective ?? '');
    _sampleIdController = TextEditingController(text: record?.sampleId ?? '');
    _notesController = TextEditingController(text: record?.notes ?? '');

    _cellLineController = TextEditingController(text: detail?.cellLine ?? '');
    _passageNumberController =
        TextEditingController(text: detail?.passageNumber ?? '');
    _transfectionReagentController =
        TextEditingController(text: detail?.transfectionReagent ?? '');
    _nucleicAcidTypeController =
        TextEditingController(text: detail?.nucleicAcidType ?? '');
    _nucleicAcidIdController =
        TextEditingController(text: detail?.nucleicAcidId ?? '');
    _plateFormatController =
        TextEditingController(text: detail?.plateFormat ?? '');
    _observationTimepointController =
        TextEditingController(text: detail?.observationTimepoint ?? '');
    _transfectionEfficiencyController =
        TextEditingController(text: detail?.transfectionEfficiency ?? '');
    _toxicityObservationController =
        TextEditingController(text: detail?.toxicityObservation ?? '');
    _endpointResultController =
        TextEditingController(text: detail?.endpointResult ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _objectiveController.dispose();
    _sampleIdController.dispose();
    _notesController.dispose();
    _cellLineController.dispose();
    _passageNumberController.dispose();
    _transfectionReagentController.dispose();
    _nucleicAcidTypeController.dispose();
    _nucleicAcidIdController.dispose();
    _plateFormatController.dispose();
    _observationTimepointController.dispose();
    _transfectionEfficiencyController.dispose();
    _toxicityObservationController.dispose();
    _endpointResultController.dispose();
    super.dispose();
  }

  String? _nullableText(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : text;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final now = DateTime.now();

    if (widget.isEditMode) {
      final oldExperiment = widget.initialRecord!;
      final oldDetail = widget.initialDetail!;

      final updatedExperiment = oldExperiment.copyWith(
        module: 'Transfection',
        title: _titleController.text.trim(),
        objective: drift.Value(_nullableText(_objectiveController)),
        sampleId: drift.Value(_nullableText(_sampleIdController)),
        notes: drift.Value(_nullableText(_notesController)),
        updatedAt: now,
      );

      final updatedDetail = oldDetail.copyWith(
        cellLine: drift.Value(_nullableText(_cellLineController)),
        passageNumber: drift.Value(_nullableText(_passageNumberController)),
        transfectionReagent:
            drift.Value(_nullableText(_transfectionReagentController)),
        nucleicAcidType:
            drift.Value(_nullableText(_nucleicAcidTypeController)),
        nucleicAcidId: drift.Value(_nullableText(_nucleicAcidIdController)),
        plateFormat: drift.Value(_nullableText(_plateFormatController)),
        observationTimepoint:
            drift.Value(_nullableText(_observationTimepointController)),
        transfectionEfficiency:
            drift.Value(_nullableText(_transfectionEfficiencyController)),
        toxicityObservation:
            drift.Value(_nullableText(_toxicityObservationController)),
        endpointResult: drift.Value(_nullableText(_endpointResultController)),
        updatedAt: now,
      );

      await widget.database.updateTransfectionExperiment(
        experiment: updatedExperiment,
        detail: updatedDetail,
      );
    } else {
      await widget.database.createTransfectionExperiment(
        experiment: ExperimentRecordsCompanion.insert(
          module: 'Transfection',
          title: _titleController.text.trim(),
          objective: drift.Value(_nullableText(_objectiveController)),
          sampleId: drift.Value(_nullableText(_sampleIdController)),
          notes: drift.Value(_nullableText(_notesController)),
          createdAt: now,
          updatedAt: now,
        ),
        transfection: TransfectionDetailsCompanion.insert(
          experimentRecordId: 0,
          cellLine: drift.Value(_nullableText(_cellLineController)),
          passageNumber: drift.Value(_nullableText(_passageNumberController)),
          transfectionReagent:
              drift.Value(_nullableText(_transfectionReagentController)),
          nucleicAcidType:
              drift.Value(_nullableText(_nucleicAcidTypeController)),
          nucleicAcidId: drift.Value(_nullableText(_nucleicAcidIdController)),
          plateFormat: drift.Value(_nullableText(_plateFormatController)),
          observationTimepoint:
              drift.Value(_nullableText(_observationTimepointController)),
          transfectionEfficiency:
              drift.Value(_nullableText(_transfectionEfficiencyController)),
          toxicityObservation:
              drift.Value(_nullableText(_toxicityObservationController)),
          endpointResult: drift.Value(_nullableText(_endpointResultController)),
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.isEditMode
              ? 'Transfection 기록이 수정되었습니다.'
              : 'Transfection 기록이 저장되었습니다.',
        ),
      ),
    );

    Navigator.of(context).pop();
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEditMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Transfection 기록 수정' : 'Transfection 기록'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionTitle('공통 정보'),
            _field(
              _titleController,
              '실험 제목',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '실험 제목을 입력하세요.';
                }
                return null;
              },
            ),
            _field(_objectiveController, '목적', maxLines: 3),
            _field(_sampleIdController, 'Sample ID'),
            _field(_notesController, '비고', maxLines: 4),

            _sectionTitle('Transfection 상세 정보'),
            _field(_cellLineController, 'Cell line'),
            _field(_passageNumberController, 'Passage number'),
            _field(_transfectionReagentController, 'Transfection reagent'),
            _field(_nucleicAcidTypeController, 'Nucleic acid type'),
            _field(_nucleicAcidIdController, 'Plasmid / siRNA / mRNA ID'),
            _field(_plateFormatController, 'Plate format'),
            _field(_observationTimepointController, 'Observation timepoint'),
            _field(_transfectionEfficiencyController, 'Transfection efficiency'),
            _field(_toxicityObservationController, 'Toxicity observation', maxLines: 3),
            _field(_endpointResultController, 'Endpoint result', maxLines: 4),

            const SizedBox(height: 8),
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
    );
  }
}