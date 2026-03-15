import 'dart:io';

import 'package:excel/excel.dart' hide Border;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:molecular_work_app/database/app_database.dart';

class CloningFormPage extends StatefulWidget {
  final AppDatabase database;

  const CloningFormPage({
    super.key,
    required this.database,
  });

  @override
  State<CloningFormPage> createState() => _CloningFormPageState();
}

class _CloningFormPageState extends State<CloningFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _experimentTitleController = TextEditingController();
  final _researcherController = TextEditingController();
  final _geneNameController = TextEditingController();
  final _insertLengthController = TextEditingController();
  final _geneSequenceController = TextEditingController();
  final _sourceController = TextEditingController();
  final _fivePrimeCustomController = TextEditingController();
  final _threePrimeCustomController = TextEditingController();
  final _vectorNotesController = TextEditingController();
  final _hostNotesController = TextEditingController();
  final _inductionOdController = TextEditingController(text: '0.4-0.6');
  final _iptgController = TextEditingController(text: '1.0');
  final _temperatureController = TextEditingController(text: '37');
  final _durationController = TextEditingController(text: '4-6');
  final _purificationController = TextEditingController(text: 'Ni-NTA (His tag)');
  final _additionalNotesController = TextEditingController();

  final List<String> _plasmidFrames = ['A', 'B', 'C'];
  final List<String> _insertDirections = ['+', '-'];
  final List<String> _restrictionSites = const [
    'EcoRI',
    'BamHI',
    'XhoI',
    'HindIII',
    'NheI',
    'NotI',
    'KpnI',
    'SalI',
    'Custom',
  ];
  final List<String> _hosts = const [
    'BL21(DE3)',
    'BL21(DE3)pLysS',
    'Rosetta(DE3)',
    'C41(DE3)',
    'Custom',
  ];

  String _selectedFrame = 'A';
  String _selectedDirection = '+';
  String _selectedFivePrimeSite = 'EcoRI';
  String _selectedThreePrimeSite = 'XhoI';
  String _selectedHost = 'BL21(DE3)pLysS';
  DateTime _selectedDate = DateTime.now();

  bool _hasHisTag = true;
  bool _hasXpressEpitope = true;
  bool _hasEnterokinaseSite = true;
  bool _sequenceVerified = false;
  bool _pilotExpressionDone = false;
  bool _solubleFractionChecked = false;

  @override
  void dispose() {
    _experimentTitleController.dispose();
    _researcherController.dispose();
    _geneNameController.dispose();
    _insertLengthController.dispose();
    _geneSequenceController.dispose();
    _sourceController.dispose();
    _fivePrimeCustomController.dispose();
    _threePrimeCustomController.dispose();
    _vectorNotesController.dispose();
    _hostNotesController.dispose();
    _inductionOdController.dispose();
    _iptgController.dispose();
    _temperatureController.dispose();
    _durationController.dispose();
    _purificationController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  String _resolvedFivePrimeSite() {
    return _selectedFivePrimeSite == 'Custom'
        ? _fivePrimeCustomController.text.trim()
        : _selectedFivePrimeSite;
  }

  String _resolvedThreePrimeSite() {
    return _selectedThreePrimeSite == 'Custom'
        ? _threePrimeCustomController.text.trim()
        : _selectedThreePrimeSite;
  }

  String _resolvedHost() {
    return _selectedHost == 'Custom'
        ? _hostNotesController.text.trim()
        : _selectedHost;
  }

  Map<String, String> _buildSummaryMap() {
    return {
      'Experiment title': _experimentTitleController.text.trim(),
      'Researcher': _researcherController.text.trim(),
      'Date': _selectedDate.toIso8601String().split('T').first,
      'Plasmid': 'pRSET $_selectedFrame ($_selectedDirection)',
      '5\' restriction site': _resolvedFivePrimeSite(),
      '3\' restriction site': _resolvedThreePrimeSite(),
      'Insert gene': _geneNameController.text.trim(),
      'Insert length (bp)': _insertLengthController.text.trim(),
      'Gene source': _sourceController.text.trim(),
      'Host': _resolvedHost(),
      'Induction OD600': _inductionOdController.text.trim(),
      'IPTG (mM)': _iptgController.text.trim(),
      'Temperature (°C)': _temperatureController.text.trim(),
      'Induction time (h)': _durationController.text.trim(),
      'Purification': _purificationController.text.trim(),
      '6xHis tag': _hasHisTag ? 'Yes' : 'No',
      'Xpress epitope': _hasXpressEpitope ? 'Yes' : 'No',
      'Enterokinase site': _hasEnterokinaseSite ? 'Yes' : 'No',
      'Sequence verified': _sequenceVerified ? 'Yes' : 'No',
      'Pilot expression done': _pilotExpressionDone ? 'Yes' : 'No',
      'Soluble fraction checked': _solubleFractionChecked ? 'Yes' : 'No',
      'Vector notes': _vectorNotesController.text.trim(),
      'Additional notes': _additionalNotesController.text.trim(),
    };
  }

  String _buildSummaryText() {
    final map = _buildSummaryMap();
    final buffer = StringBuffer();

    buffer.writeln('DNA Cloning SOP Summary');
    buffer.writeln('======================');
    map.forEach((key, value) {
      buffer.writeln('$key: $value');
    });

    if (_geneSequenceController.text.trim().isNotEmpty) {
      buffer.writeln('\nInsert sequence');
      buffer.writeln('---------------');
      buffer.writeln(_geneSequenceController.text.trim());
    }

    return buffer.toString();
  }

  Future<void> _saveToDatabase() async {
    if (!_formKey.currentState!.validate()) return;

    final summary = _buildSummaryText();

    // TODO:
    // Replace this section with your actual Drift table insert.
    // Example shape:
    // await widget.database.into(widget.database.cloningRecords).insert(
    //   CloningRecordsCompanion.insert(
    //     title: _experimentTitleController.text.trim(),
    //     researcher: _researcherController.text.trim(),
    //     summaryJson: jsonEncode(_buildSummaryMap()),
    //     createdAt: _selectedDate,
    //   ),
    // );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('저장 준비 완료: ${summary.split('\n').first}'),
      ),
    );
  }

  Future<void> _exportPdf() async {
    if (!_formKey.currentState!.validate()) return;

    final pdf = pw.Document();
    final summary = _buildSummaryMap();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text('DNA Cloning SOP'),
          ),
          pw.Paragraph(text: 'Generated from CloningFormPage'),
          pw.TableHelper.fromTextArray(
            headers: const ['Field', 'Value'],
            data: summary.entries
                .map((entry) => [entry.key, entry.value])
                .toList(),
          ),
          pw.SizedBox(height: 16),
          pw.Text('Insert sequence'),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey700),
            ),
            child: pw.Text(
              _geneSequenceController.text.trim().isEmpty
                  ? 'N/A'
                  : _geneSequenceController.text.trim(),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text('Additional notes'),
          pw.Text(
            _additionalNotesController.text.trim().isEmpty
                ? 'N/A'
                : _additionalNotesController.text.trim(),
          ),
        ],
      ),
    );

    final bytes = await pdf.save();
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }

  Future<void> _exportExcel() async {
    if (!_formKey.currentState!.validate()) return;

    final excel = Excel.createExcel();
    final sheet = excel['Cloning SOP'];
    final summary = _buildSummaryMap();

    sheet.appendRow([
      TextCellValue('Field'),
      TextCellValue('Value'),
    ]);

    for (final entry in summary.entries) {
      sheet.appendRow([
        TextCellValue(entry.key),
        TextCellValue(entry.value),
      ]);
    }

    if (_geneSequenceController.text.trim().isNotEmpty) {
      sheet.appendRow([TextCellValue('Insert sequence'), TextCellValue('')]);
      sheet.appendRow([
        TextCellValue(_geneSequenceController.text.trim()),
        TextCellValue(''),
      ]);
    }

    final fileBytes = excel.encode();
    if (fileBytes == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final safeTitle = (_experimentTitleController.text.trim().isEmpty
            ? 'cloning_sop'
            : _experimentTitleController.text.trim())
        .replaceAll(RegExp(r'[^a-zA-Z0-9가-힣_-]'), '_');
    final file = File('${dir.path}/$safeTitle.xlsx')
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excel 저장 완료: ${file.path}')),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> values,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: values
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    int maxLines = 1,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    final summary = _buildSummaryMap();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DNA Cloning SOP'),
        actions: [
          IconButton(
            tooltip: 'Export PDF',
            onPressed: _exportPdf,
            icon: const Icon(Icons.picture_as_pdf),
          ),
          IconButton(
            tooltip: 'Export Excel',
            onPressed: _exportExcel,
            icon: const Icon(Icons.table_view),
          ),
          IconButton(
            tooltip: 'Save',
            onPressed: _saveToDatabase,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildSectionCard(
              title: '1. 기본 정보',
              subtitle: '실험 제목, 작성자, 날짜를 먼저 기록합니다.',
              children: [
                _buildTextField(
                  label: 'Experiment title',
                  controller: _experimentTitleController,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? '실험 제목을 입력하세요.'
                      : null,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Researcher',
                  controller: _researcherController,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? '작성자를 입력하세요.'
                      : null,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    'Date: ${_selectedDate.toIso8601String().split('T').first}',
                  ),
                ),
              ],
            ),
            _buildSectionCard(
              title: '2. pRSET plasmid 선택',
              subtitle: 'frame(A/B/C)과 insert 방향(+/-)을 선택합니다.',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown<String>(
                        label: 'Plasmid frame',
                        value: _selectedFrame,
                        values: _plasmidFrames,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedFrame = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown<String>(
                        label: 'Insert direction',
                        value: _selectedDirection,
                        values: _insertDirections,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedDirection = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('6×His tag 포함'),
                  value: _hasHisTag,
                  onChanged: (value) {
                    setState(() => _hasHisTag = value ?? true);
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Xpress epitope 포함'),
                  value: _hasXpressEpitope,
                  onChanged: (value) {
                    setState(() => _hasXpressEpitope = value ?? true);
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Enterokinase cleavage site 포함'),
                  value: _hasEnterokinaseSite,
                  onChanged: (value) {
                    setState(() => _hasEnterokinaseSite = value ?? true);
                  },
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Vector notes',
                  controller: _vectorNotesController,
                  maxLines: 3,
                ),
              ],
            ),
            _buildSectionCard(
              title: '3. 제한효소 site 선택',
              subtitle: '5′/3′ restriction site를 고르고 custom site도 입력할 수 있습니다.',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown<String>(
                        label: '5\' site',
                        value: _selectedFivePrimeSite,
                        values: _restrictionSites,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedFivePrimeSite = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown<String>(
                        label: '3\' site',
                        value: _selectedThreePrimeSite,
                        values: _restrictionSites,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedThreePrimeSite = value);
                        },
                      ),
                    ),
                  ],
                ),
                if (_selectedFivePrimeSite == 'Custom') ...[
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Custom 5\' site',
                    controller: _fivePrimeCustomController,
                    validator: (value) {
                      if (_selectedFivePrimeSite == 'Custom' &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Custom 5\' site를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ],
                if (_selectedThreePrimeSite == 'Custom') ...[
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Custom 3\' site',
                    controller: _threePrimeCustomController,
                    validator: (value) {
                      if (_selectedThreePrimeSite == 'Custom' &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Custom 3\' site를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ],
              ],
            ),
            _buildSectionCard(
              title: '4. Insert gene 입력',
              subtitle: 'gene 이름, 길이, source, sequence를 기록합니다.',
              children: [
                _buildTextField(
                  label: 'Insert gene name',
                  controller: _geneNameController,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Insert gene 이름을 입력하세요.'
                      : null,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Insert length (bp)',
                  controller: _insertLengthController,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Gene source',
                  controller: _sourceController,
                  hintText: 'cDNA, synthetic gene, genomic DNA 등',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Insert gene sequence / ORF',
                  controller: _geneSequenceController,
                  maxLines: 6,
                  hintText: 'ATG... 형태로 붙여 넣기',
                ),
              ],
            ),
            _buildSectionCard(
              title: '5. Sequence 검증',
              subtitle: 'orientation, reading frame, junction 검증 여부를 체크합니다.',
              children: [
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sequence verified'),
                  subtitle: const Text('Orientation / frame / junction 확인'),
                  value: _sequenceVerified,
                  onChanged: (value) {
                    setState(() => _sequenceVerified = value ?? false);
                  },
                ),
              ],
            ),
            _buildSectionCard(
              title: '6. 발현 조건',
              subtitle: 'T7 host, OD600, IPTG, 온도, 시간을 설정합니다.',
              children: [
                _buildDropdown<String>(
                  label: 'Expression host',
                  value: _selectedHost,
                  values: _hosts,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedHost = value);
                  },
                ),
                if (_selectedHost == 'Custom') ...[
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Custom host',
                    controller: _hostNotesController,
                    validator: (value) {
                      if (_selectedHost == 'Custom' &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Custom host를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Induction OD600',
                        controller: _inductionOdController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        label: 'IPTG (mM)',
                        controller: _iptgController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Temperature (°C)',
                        controller: _temperatureController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        label: 'Induction time (h)',
                        controller: _durationController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Purification method',
                  controller: _purificationController,
                ),
              ],
            ),
            _buildSectionCard(
              title: '7. Pilot / QC 체크',
              subtitle: 'expression time course와 soluble fraction 확인 상태를 저장합니다.',
              children: [
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Pilot expression completed'),
                  value: _pilotExpressionDone,
                  onChanged: (value) {
                    setState(() => _pilotExpressionDone = value ?? false);
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Soluble fraction checked'),
                  value: _solubleFractionChecked,
                  onChanged: (value) {
                    setState(() => _solubleFractionChecked = value ?? false);
                  },
                ),
                _buildTextField(
                  label: 'Additional notes',
                  controller: _additionalNotesController,
                  maxLines: 4,
                ),
              ],
            ),
            _buildSectionCard(
              title: '8. 요약 미리보기',
              subtitle: '저장 또는 PDF/Excel 출력 전에 핵심 내용을 확인합니다.',
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summary.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text('${entry.key}: ${entry.value}'),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: _saveToDatabase,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Result'),
                ),
                OutlinedButton.icon(
                  onPressed: _exportPdf,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Export PDF'),
                ),
                OutlinedButton.icon(
                  onPressed: _exportExcel,
                  icon: const Icon(Icons.table_view),
                  label: const Text('Export Excel'),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
