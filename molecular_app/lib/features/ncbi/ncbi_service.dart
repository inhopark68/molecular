import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ncbi_models.dart';

class NcbiService {
  NcbiService({
    http.Client? client,
    required this.email,
    this.tool = 'molecular_app',
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String email;
  final String tool;

  static const String _eutilsBase =
      'https://eutils.ncbi.nlm.nih.gov/entrez/eutils';
  static const String _datasetsBase =
      'https://api.ncbi.nlm.nih.gov/datasets/v2';

  Map<String, String> get _commonQuery => {
        'tool': tool,
        'email': email,
        'retmode': 'json',
      };

  Future<List<NcbiGeneCandidate>> searchGenes({
    required String symbol,
    required String organism,
    int maxResults = 5,
  }) async {
    final cleanedSymbol = symbol.trim();
    final cleanedOrganism = organism.trim();

    if (cleanedSymbol.isEmpty || cleanedOrganism.isEmpty) {
      return const [];
    }

    final term = '$cleanedSymbol[Gene Name] AND $cleanedOrganism[Organism]';

    final searchUri = Uri.parse('$_eutilsBase/esearch.fcgi').replace(
      queryParameters: {
        ..._commonQuery,
        'db': 'gene',
        'term': term,
        'retmax': '$maxResults',
      },
    );

    final searchResp = await _client.get(searchUri);
    if (searchResp.statusCode != 200) {
      throw Exception('NCBI gene search failed: ${searchResp.statusCode}');
    }

    final searchJson = jsonDecode(searchResp.body) as Map<String, dynamic>;
    final esearchResult =
        searchJson['esearchresult'] as Map<String, dynamic>? ?? {};
    final ids = (esearchResult['idlist'] as List<dynamic>? ?? const [])
        .map((e) => e.toString())
        .toList();

    if (ids.isEmpty) return const [];

    final summaryUri = Uri.parse('$_eutilsBase/esummary.fcgi').replace(
      queryParameters: {
        ..._commonQuery,
        'db': 'gene',
        'id': ids.join(','),
      },
    );

    final summaryResp = await _client.get(summaryUri);
    if (summaryResp.statusCode != 200) {
      throw Exception('NCBI gene summary failed: ${summaryResp.statusCode}');
    }

    final summaryJson = jsonDecode(summaryResp.body) as Map<String, dynamic>;
    final result =
        summaryJson['result'] as Map<String, dynamic>? ?? <String, dynamic>{};

    final candidates = <NcbiGeneCandidate>[];
    for (final id in ids) {
      final item = result[id] as Map<String, dynamic>?;
      if (item == null) continue;

      final organismInfo = item['organism'] as Map<String, dynamic>?;

      candidates.add(
        NcbiGeneCandidate(
          geneId: id,
          symbol: (item['name'] ?? '').toString(),
          description: (item['description'] ?? '').toString(),
          organism: (organismInfo?['scientificname'] ?? '').toString(),
          summary: item['summary']?.toString(),
        ),
      );
    }

    return candidates;
  }

  Future<NcbiGeneImportResult> importGene({
    required String geneId,
    String? organismHint,
    bool includePubMed = true,
  }) async {
    final geneMeta = await _fetchGeneSummary(geneId);

    var accessions = await _fetchGeneDatasetsAccessions(geneId);

    if ((accessions.$1 == null || accessions.$1!.isEmpty)) {
      final fallbackRna = await _fallbackSearchRefseqRnaAccession(
        symbol: geneMeta.symbol,
        organism: organismHint ?? geneMeta.organism,
      );
      accessions = (fallbackRna, accessions.$2);
    }

    final sequenceBundle = await _tryFetchSequences(
      rnaAccession: accessions.$1,
      proteinAccession: accessions.$2,
    );

    List<String> pmids = const [];
    if (includePubMed) {
      pmids = await _searchPubMedPmids(
        symbol: geneMeta.symbol,
        organism: organismHint ?? geneMeta.organism,
      );
    }

    return NcbiGeneImportResult(
      geneId: geneId,
      symbol: geneMeta.symbol,
      description: geneMeta.description,
      organism: geneMeta.organism,
      summary: geneMeta.summary,
      refseqRnaAccession: accessions.$1,
      refseqProteinAccession: accessions.$2,
      nucleotideSequence: sequenceBundle.$1,
      cdsSequence: sequenceBundle.$2,
      proteinSequence: sequenceBundle.$3,
      pmids: pmids,
    );
  }

  Future<NcbiGeneCandidate> _fetchGeneSummary(String geneId) async {
    final summaryUri = Uri.parse('$_eutilsBase/esummary.fcgi').replace(
      queryParameters: {
        ..._commonQuery,
        'db': 'gene',
        'id': geneId,
      },
    );

    final resp = await _client.get(summaryUri);
    if (resp.statusCode != 200) {
      throw Exception('NCBI gene summary failed: ${resp.statusCode}');
    }

    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    final result = json['result'] as Map<String, dynamic>? ?? {};
    final item = result[geneId] as Map<String, dynamic>?;

    if (item == null) {
      throw Exception('Gene summary not found for GeneID=$geneId');
    }

    final organismInfo = item['organism'] as Map<String, dynamic>?;

    return NcbiGeneCandidate(
      geneId: geneId,
      symbol: (item['name'] ?? '').toString(),
      description: (item['description'] ?? '').toString(),
      organism: (organismInfo?['scientificname'] ?? '').toString(),
      summary: item['summary']?.toString(),
    );
  }

  /// returns (rnaRefSeq, proteinRefSeq)
  Future<(String?, String?)> _fetchGeneDatasetsAccessions(String geneId) async {
    final uri = Uri.parse('$_datasetsBase/gene/id/$geneId/dataset_report');

    final resp = await _client.get(uri);
    if (resp.statusCode != 200) {
      return (null, null);
    }

    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    final reports = json['reports'] as List<dynamic>? ?? const [];

    String? rna;
    String? protein;

    for (final report in reports) {
      final map = report as Map<String, dynamic>;
      final gene = map['gene'] as Map<String, dynamic>? ?? {};

      final transcripts = gene['transcripts'] as List<dynamic>? ?? const [];
      for (final t in transcripts) {
        final m = t as Map<String, dynamic>;
        final accession =
            m['accession_version']?.toString() ?? m['accession']?.toString();

        if (accession != null &&
            (accession.startsWith('NM_') || accession.startsWith('XM_'))) {
          rna ??= accession;
        }
      }

      final proteins = gene['proteins'] as List<dynamic>? ?? const [];
      for (final p in proteins) {
        final m = p as Map<String, dynamic>;
        final accession =
            m['accession_version']?.toString() ?? m['accession']?.toString();

        if (accession != null &&
            (accession.startsWith('NP_') || accession.startsWith('XP_'))) {
          protein ??= accession;
        }
      }
    }

    return (rna, protein);
  }

  Future<String?> _fallbackSearchRefseqRnaAccession({
    required String symbol,
    required String organism,
  }) async {
    final term =
        '$symbol[Gene] AND $organism[Organism] AND srcdb_refseq[PROP] AND biomol_mrna[PROP]';

    final uri = Uri.parse('$_eutilsBase/esearch.fcgi').replace(
      queryParameters: {
        ..._commonQuery,
        'db': 'nuccore',
        'term': term,
        'retmax': '1',
      },
    );

    final resp = await _client.get(uri);
    if (resp.statusCode != 200) return null;

    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    final ids = (((json['esearchresult'] as Map<String, dynamic>?)?['idlist'])
                as List<dynamic>? ??
            const [])
        .map((e) => e.toString())
        .toList();

    if (ids.isEmpty) return null;

    final summaryUri = Uri.parse('$_eutilsBase/esummary.fcgi').replace(
      queryParameters: {
        ..._commonQuery,
        'db': 'nuccore',
        'id': ids.first,
      },
    );

    final summaryResp = await _client.get(summaryUri);
    if (summaryResp.statusCode != 200) return null;

    final summaryJson = jsonDecode(summaryResp.body) as Map<String, dynamic>;
    final result = summaryJson['result'] as Map<String, dynamic>? ?? {};
    final item = result[ids.first] as Map<String, dynamic>?;

    if (item == null) return null;

    final accession = item['accessionversion']?.toString() ??
        item['caption']?.toString();

    return accession;
  }

  /// returns (transcriptSeq, cdsSeq, proteinSeq)
  Future<(String?, String?, String?)> _tryFetchSequences({
    String? rnaAccession,
    String? proteinAccession,
  }) async {
    String? transcript;
    String? cds;
    String? protein;

    if (rnaAccession != null && rnaAccession.isNotEmpty) {
      transcript = await _fetchFastaSequence(
        db: 'nuccore',
        accession: rnaAccession,
      );

      cds = await _fetchCdsSequenceFromNuccore(rnaAccession);
    }

    if (proteinAccession != null && proteinAccession.isNotEmpty) {
      protein = await _fetchFastaSequence(
        db: 'protein',
        accession: proteinAccession,
      );
    }

    return (transcript, cds, protein);
  }

  Future<String?> _fetchFastaSequence({
    required String db,
    required String accession,
  }) async {
    final uri = Uri.parse('$_eutilsBase/efetch.fcgi').replace(
      queryParameters: {
        'db': db,
        'id': accession,
        'rettype': 'fasta',
        'retmode': 'text',
        'tool': tool,
        'email': email,
      },
    );

    final resp = await _client.get(uri);
    if (resp.statusCode != 200) return null;

    final body = resp.body.trim();
    if (body.isEmpty || !body.startsWith('>')) return null;

    final lines = body.split('\n');
    final seq = lines.skip(1).join('').replaceAll(RegExp(r'\s+'), '').trim();
    return seq.isEmpty ? null : seq;
  }

  Future<String?> _fetchCdsSequenceFromNuccore(String accession) async {
    final uri = Uri.parse('$_eutilsBase/efetch.fcgi').replace(
      queryParameters: {
        'db': 'nuccore',
        'id': accession,
        'rettype': 'fasta_cds_na',
        'retmode': 'text',
        'tool': tool,
        'email': email,
      },
    );

    final resp = await _client.get(uri);
    if (resp.statusCode != 200) return null;

    final body = resp.body.trim();
    if (body.isEmpty || !body.startsWith('>')) return null;

    final entries = body.split(RegExp(r'(?=>)'));
    if (entries.isEmpty) return null;

    final firstEntry = entries.first.trim();
    final lines = firstEntry.split('\n');
    if (lines.length < 2) return null;

    final seq = lines.skip(1).join('').replaceAll(RegExp(r'\s+'), '').trim();
    return seq.isEmpty ? null : seq;
  }

  Future<List<String>> _searchPubMedPmids({
    required String symbol,
    required String organism,
    int maxResults = 5,
  }) async {
    final cleanedSymbol = symbol.trim();
    final cleanedOrganism = organism.trim();

    if (cleanedSymbol.isEmpty || cleanedOrganism.isEmpty) {
      return const [];
    }

    final term = '$cleanedSymbol AND $cleanedOrganism';

    final uri = Uri.parse('$_eutilsBase/esearch.fcgi').replace(
      queryParameters: {
        ..._commonQuery,
        'db': 'pubmed',
        'term': term,
        'retmax': '$maxResults',
        'sort': 'relevance',
      },
    );

    final resp = await _client.get(uri);
    if (resp.statusCode != 200) return const [];

    final json = jsonDecode(resp.body) as Map<String, dynamic>;
    final esearchResult =
        json['esearchresult'] as Map<String, dynamic>? ?? {};

    return (esearchResult['idlist'] as List<dynamic>? ?? const [])
        .map((e) => e.toString())
        .toList();
  }

  void dispose() {
    _client.close();
  }
}