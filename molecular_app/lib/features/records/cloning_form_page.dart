import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:excel/excel.dart' as ex;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:molecular_app/database/app_database.dart';
import 'package:molecular_app/features/ncbi/ncbi_models.dart';
import 'package:molecular_app/features/ncbi/ncbi_service.dart';

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
  final _customPlasmidController = TextEditingController();
  final _vectorNotesController = TextEditingController();
  final _selectedColonyController = TextEditingController();
  final _screeningNotesController = TextEditingController();
  final _additionalNotesController = TextEditingController();

  final _customHostBacteriaController = TextEditingController();
  final _customAntibioticController = TextEditingController();
  final _transformationNotesController = TextEditingController();
  final _positiveCloneCountController = TextEditingController();
  final _customSequencingPrimerController = TextEditingController();
  final _customOrganismController = TextEditingController();

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

  final List<String> _hostBacteriaOptions = const [
    'DH5α',
    'TOP10',
    'JM109',
    'XL1-Blue',
    'Stbl3',
    'BL21(DE3)',
    'Rosetta',
    'Custom',
  ];

  final List<String> _antibioticOptions = const [
    'Ampicillin',
    'Kanamycin',
    'Chloramphenicol',
    'Spectinomycin',
    'Tetracycline',
    'Gentamicin',
    'Custom',
  ];

  final List<String> _screeningMethods = const [
    'Colony PCR',
    'Restriction digest',
    'Colony PCR + Restriction digest',
    'Sequencing only',
    'Custom',
  ];

  final List<String> _sequencingPrimerOptions = const [
    'T7 promoter',
    'T7 terminator',
    'SP6',
    'M13 Forward',
    'M13 Reverse',
    'CMV-F',
    'BGH Reverse',
    'SV40 Forward',
    'Gene-specific Forward',
    'Gene-specific Reverse',
    'Custom',
  ];

  final List<String> _organismOptions = const [
    'Homo sapiens',
    'Mus musculus',
    'Rattus norvegicus',
    'Custom',
  ];

  late final NcbiService _ncbiService;

  String? _selectedPlasmid;
  String _selectedFrame = 'A';
  String _selectedDirection = '+';
  String _selectedFivePrimeSite = 'EcoRI';
  String _selectedThreePrimeSite = 'XhoI';
  String _selectedHostBacteria = 'DH5α';
  String _selectedAntibiotic = 'Ampicillin';
  String _selectedScreeningMethod = 'Colony PCR';
  String _selectedSequencingPrimer = 'T7 promoter';
  String _selectedOrganism = 'Homo sapiens';
  DateTime _selectedDate = DateTime.now();

  bool _restrictionDigestConfirmed = false;
  bool _colonyPcrConfirmed = false;
  bool _miniprepDone = false;
  bool _insertSequenceVerified = false;
  bool _isImportingNcbi = false;

  @override
  void initState() {
    super.initState();
    _ncbiService = NcbiService(
      email: 'your_email@example.com',
      tool: 'molecular_app',
    );
  }

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
    _customPlasmidController.dispose();
    _vectorNotesController.dispose();
    _selectedColonyController.dispose();
    _screeningNotesController.dispose();
    _additionalNotesController.dispose();
    _customHostBacteriaController.dispose();
    _customAntibioticController.dispose();
    _transformationNotesController.dispose();
    _positiveCloneCountController.dispose();
    _customSequencingPrimerController.dispose();
    _customOrganismController.dispose();
    _ncbiService.dispose();
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

  String _resolvedOrganism() {
    return _selectedOrganism == 'Custom'
        ? _customOrganismController.text.trim()
        : _selectedOrganism;
  }

  String _resolvedPlasmidName() {
    if (_selectedPlasmid == null) return '';
    return _selectedPlasmid == 'Custom'
        ? _customPlasmidController.text.trim()
        : _selectedPlasmid!;
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

  String _resolvedHostBacteria() {
    return _selectedHostBacteria == 'Custom'
        ? _customHostBacteriaController.text.trim()
        : _selectedHostBacteria;
  }

  String _resolvedAntibiotic() {
    return _selectedAntibiotic == 'Custom'
        ? _customAntibioticController.text.trim()
        : _selectedAntibiotic;
  }

  String _resolvedSequencingPrimer() {
    return _selectedSequencingPrimer == 'Custom'
        ? _customSequencingPrimerController.text.trim()
        : _selectedSequencingPrimer;
  }

  Map<String, String> _buildSummaryMap() {
    return {
      'Experiment title': _experimentTitleController.text.trim(),
      'Researcher': _researcherController.text.trim(),
      'Date': _selectedDate.toIso8601String().split('T').first,
      'Organism': _resolvedOrganism(),
      'Plasmid': _resolvedPlasmidName().isEmpty
          ? 'Not selected'
          : '${_resolvedPlasmidName()} $_selectedFrame ($_selectedDirection)',
      '5\' restriction site': _resolvedFivePrimeSite(),
      '3\' restriction site': _resolvedThreePrimeSite(),
      'Insert gene': _geneNameController.text.trim(),
      'Insert length (bp)': _insertLengthController.text.trim(),
      'Gene source': _sourceController.text.trim(),
      'Host bacteria': _resolvedHostBacteria(),
      'Selection antibiotic': _resolvedAntibiotic(),
      'Positive clone count': _positiveCloneCountController.text.trim(),
      'Transformation notes': _transformationNotesController.text.trim(),
      'Screening method': _selectedScreeningMethod,
      'Selected colony': _selectedColonyController.text.trim(),
      'Restriction digest confirmed':
          _restrictionDigestConfirmed ? 'Yes' : 'No',
      'Colony PCR confirmed': _colonyPcrConfirmed ? 'Yes' : 'No',
      'Miniprep done': _miniprepDone ? 'Yes' : 'No',
      'Insert sequence verified': _insertSequenceVerified ? 'Yes' : 'No',
      'Sequencing primer': _resolvedSequencingPrimer(),
      'Screening notes': _screeningNotesController.text.trim(),
      'Vector notes': _vectorNotesController.text.trim(),
      'Additional notes': _additionalNotesController.text.trim(),
    };
  }

  Future<NcbiGeneCandidate?> _pickGeneCandidate(
    List<NcbiGeneCandidate> items,
  ) async {
    return showDialog<NcbiGeneCandidate>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select NCBI Gene'),
          content: SizedBox(
            width: 600,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text('${item.symbol} (${item.organism})'),
                  subtitle: Text(
                    '${item.description} • GeneID ${item.geneId}',
                  ),
                  onTap: () => Navigator.of(context).pop(item),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _importFromNcbi() async {
    final geneSymbol = _geneNameController.text.trim();
    final organism = _resolvedOrganism();

    if (geneSymbol.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('먼저 gene symbol을 입력하세요.')),
      );
      return;
    }

    if (organism.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('먼저 organism을 선택하거나 입력하세요.')),
      );
      return;
    }

    setState(() => _isImportingNcbi = true);

    try {
      final candidates = await _ncbiService.searchGenes(
        symbol: geneSymbol,
        organism: organism,
      );

      if (candidates.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('NCBI에서 일치하는 gene을 찾지 못했습니다.')),
        );
        return;
      }

      final selectedCandidate = candidates.length == 1
          ? candidates.first
          : await _pickGeneCandidate(candidates);

      if (selectedCandidate == null) return;

      final result = await _ncbiService.importGene(
        geneId: selectedCandidate.geneId,
        organismHint: selectedCandidate.organism,
        includePubMed: true,
      );

      _geneNameController.text = result.symbol;
      _sourceController.text =
          'NCBI Gene ${result.geneId} / ${result.organism}';

      final preferredSequence =
          (result.cdsSequence ?? '').isNotEmpty
              ? result.cdsSequence!
              : (result.nucleotideSequence ?? '');

      if (preferredSequence.isNotEmpty) {
        _geneSequenceController.text = preferredSequence;
        _insertLengthController.text = preferredSequence.length.toString();
      } else {
        _geneSequenceController.clear();
        _insertLengthController.clear();

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('유전자 메타데이터는 찾았지만 ORF/CDS 서열은 자동으로 가져오지 못했습니다.'),
          ),
        );
      }

      final notes = <String>[
        if (result.description.isNotEmpty)
          'Description: ${result.description}',
        if ((result.summary ?? '').isNotEmpty)
          'Summary: ${result.summary}',
        if ((result.refseqRnaAccession ?? '').isNotEmpty)
          'RefSeq RNA: ${result.refseqRnaAccession}',
        if ((result.refseqProteinAccession ?? '').isNotEmpty)
          'RefSeq Protein: ${result.refseqProteinAccession}',
        if ((result.cdsSequence ?? '').isNotEmpty)
          'Sequence type: CDS / ORF',
        if ((result.cdsSequence ?? '').isEmpty &&
            (result.nucleotideSequence ?? '').isNotEmpty)
          'Sequence type: Transcript RNA',
        if (result.pmids.isNotEmpty)
          'PMIDs: ${result.pmids.join(', ')}',
      ].join('\n');

      _additionalNotesController.text = notes;

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('NCBI에서 ${result.symbol} 정보를 불러왔습니다.')),
      );

      setState(() {});
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('NCBI 불러오기 실패: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isImportingNcbi = false);
      }
    }
  }

  Future<void> _saveToDatabase() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final experimentId = await widget.database.createCloningRecord(
        experiment: ExperimentRecordsCompanion.insert(
          title: _experimentTitleController.text.trim(),
          module: 'DNA Cloning',
          createdAt: Value(_selectedDate),
          updatedAt: Value(DateTime.now()),
          notes: Value(jsonEncode(_buildSummaryMap())),
        ),
        cloning: CloningDetailsCompanion(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cloning record 저장 완료 (ID: $experimentId)')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('저장 실패: $e')),
      );
    }
  }

  Future<void> _exportPdf() async {
    if (!_formKey.currentState!.validate()) return;

    final pdf = pw.Document();
    final summary = _buildSummaryMap();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(level: 0, child: pw.Text('DNA Cloning SOP')),
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
        ],
      ),
    );

    final bytes = await pdf.save();
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }

  Future<void> _exportExcel() async {
    if (!_formKey.currentState!.validate()) return;

    final excel = ex.Excel.createExcel();
    final sheet = excel['Cloning SOP'];
    final summary = _buildSummaryMap();

    sheet.appendRow([
      ex.TextCellValue('Field'),
      ex.TextCellValue('Value'),
    ]);

    for (final entry in summary.entries) {
      sheet.appendRow([
        ex.TextCellValue(entry.key),
        ex.TextCellValue(entry.value),
      ]);
    }

    if (_geneSequenceController.text.trim().isNotEmpty) {
      sheet.appendRow([
        ex.TextCellValue('Insert sequence'),
        ex.TextCellValue(''),
      ]);
      sheet.appendRow([
        ex.TextCellValue(_geneSequenceController.text.trim()),
        ex.TextCellValue(''),
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildPlasmidSelector() {
    return StreamBuilder<List<Plasmid>>(
      stream: widget.database.watchAllPlasmids(),
      builder: (context, snapshot) {
        final plasmids = snapshot.data ?? [];

        final plasmidOptions = <String>[
          ...plasmids
              .map((p) => p.plasmidName)
              .where((e) => e.trim().isNotEmpty)
              .toSet(),
          'Custom',
        ];

        if (_selectedPlasmid == null && plasmidOptions.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            setState(() {
              _selectedPlasmid = plasmidOptions.first;
            });
          });
        }

        final selectedValue = (_selectedPlasmid != null &&
                plasmidOptions.contains(_selectedPlasmid))
            ? _selectedPlasmid
            : (plasmidOptions.isNotEmpty ? plasmidOptions.first : 'Custom');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: const InputDecoration(
                labelText: 'Plasmid name',
              ),
              items: plasmidOptions
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() => _selectedPlasmid = value);
              },
              validator: (value) {
                if ((value == null || value.isEmpty) &&
                    _customPlasmidController.text.trim().isEmpty) {
                  return 'Plasmid를 선택하세요.';
                }
                return null;
              },
            ),
            if (snapshot.connectionState == ConnectionState.waiting)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('Loading plasmid list...'),
              ),
            if (_selectedPlasmid == 'Custom') ...[
              const SizedBox(height: 12),
              _buildTextField(
                label: 'Custom plasmid name',
                controller: _customPlasmidController,
                validator: (value) {
                  if (_selectedPlasmid == 'Custom' &&
                      (value == null || value.trim().isEmpty)) {
                    return 'Custom plasmid 이름을 입력하세요.';
                  }
                  return null;
                },
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildOrganismSelector() {
    return Column(
      children: [
        _buildDropdown<String>(
          label: 'Organism',
          value: _selectedOrganism,
          values: _organismOptions,
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selectedOrganism = value);
          },
        ),
        if (_selectedOrganism == 'Custom') ...[
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Custom organism',
            controller: _customOrganismController,
            hintText: '예: Homo sapiens',
            validator: (value) {
              if (_selectedOrganism == 'Custom' &&
                  (value == null || value.trim().isEmpty)) {
                return 'Custom organism을 입력하세요.';
              }
              return null;
            },
          ),
        ],
      ],
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
              subtitle: '실험 제목, 작성자, 날짜를 기록합니다.',
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
              title: '2. Plasmid 선택',
              subtitle: 'plasmid 종류, frame(A/B/C), insert 방향(+/-)을 선택합니다.',
              children: [
                _buildPlasmidSelector(),
                const SizedBox(height: 12),
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
                _buildTextField(
                  label: 'Vector notes',
                  controller: _vectorNotesController,
                  maxLines: 3,
                ),
              ],
            ),
            _buildSectionCard(
              title: '3. Restriction site 선택',
              subtitle: '5′ / 3′ restriction site를 선택합니다.',
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
              title: '4. Gene insert 입력',
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
                _buildOrganismSelector(),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.icon(
                    onPressed: _isImportingNcbi ? null : _importFromNcbi,
                    icon: const Icon(Icons.download),
                    label: Text(
                      _isImportingNcbi
                          ? 'Importing from NCBI...'
                          : 'Import from NCBI',
                    ),
                  ),
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
              title: '5. Transformation and clone selection',
              subtitle:
                  'cloning host bacteria, selection antibiotic, positive clone selection 정보를 기록합니다.',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown<String>(
                        label: 'Host bacteria',
                        value: _selectedHostBacteria,
                        values: _hostBacteriaOptions,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedHostBacteria = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown<String>(
                        label: 'Selection antibiotic',
                        value: _selectedAntibiotic,
                        values: _antibioticOptions,
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedAntibiotic = value);
                        },
                      ),
                    ),
                  ],
                ),
                if (_selectedHostBacteria == 'Custom') ...[
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Custom host bacteria',
                    controller: _customHostBacteriaController,
                    validator: (value) {
                      if (_selectedHostBacteria == 'Custom' &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Custom host bacteria를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ],
                if (_selectedAntibiotic == 'Custom') ...[
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Custom antibiotic',
                    controller: _customAntibioticController,
                    validator: (value) {
                      if (_selectedAntibiotic == 'Custom' &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Custom antibiotic를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Positive clone count',
                  controller: _positiveCloneCountController,
                  hintText: '예: 3',
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Transformation / selection notes',
                  controller: _transformationNotesController,
                  maxLines: 4,
                  hintText:
                      '예: DH5α transformation 후 Ampicillin plate에서 colony 8개 확인, positive clone 3개 선별',
                ),
              ],
            ),
            _buildSectionCard(
              title: '6. Construct screening and selection',
              subtitle: '선별한 colony 또는 construct를 screening 결과와 함께 기록합니다.',
              children: [
                _buildDropdown<String>(
                  label: 'Screening method',
                  value: _selectedScreeningMethod,
                  values: _screeningMethods,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedScreeningMethod = value);
                  },
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Selected colony / construct ID',
                  controller: _selectedColonyController,
                  hintText: '예: Colony #3, Clone A2',
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Restriction digest confirmed'),
                  value: _restrictionDigestConfirmed,
                  onChanged: (value) {
                    setState(() => _restrictionDigestConfirmed = value ?? false);
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Colony PCR confirmed'),
                  value: _colonyPcrConfirmed,
                  onChanged: (value) {
                    setState(() => _colonyPcrConfirmed = value ?? false);
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Miniprep completed'),
                  value: _miniprepDone,
                  onChanged: (value) {
                    setState(() => _miniprepDone = value ?? false);
                  },
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  label: 'Screening notes',
                  controller: _screeningNotesController,
                  maxLines: 4,
                  hintText: '예: Colony PCR positive, digest band size correct',
                ),
              ],
            ),
            _buildSectionCard(
              title: '7. Insert sequence 확인',
              subtitle: '최종 선택 construct의 insert sequence 확인 결과를 기록합니다.',
              children: [
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Insert sequence verified'),
                  subtitle: const Text(
                    'orientation / frame / junction / mutation 여부 확인',
                  ),
                  value: _insertSequenceVerified,
                  onChanged: (value) {
                    setState(() => _insertSequenceVerified = value ?? false);
                  },
                ),
                const SizedBox(height: 12),
                _buildDropdown<String>(
                  label: 'Sequencing primer',
                  value: _selectedSequencingPrimer,
                  values: _sequencingPrimerOptions,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedSequencingPrimer = value);
                  },
                ),
                if (_selectedSequencingPrimer == 'Custom') ...[
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Custom sequencing primer',
                    controller: _customSequencingPrimerController,
                    validator: (value) {
                      if (_selectedSequencingPrimer == 'Custom' &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Custom sequencing primer를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 12),
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