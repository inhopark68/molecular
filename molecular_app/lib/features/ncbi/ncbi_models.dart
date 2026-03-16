class NcbiGeneCandidate {
  final String geneId;
  final String symbol;
  final String description;
  final String organism;
  final String? summary;

  const NcbiGeneCandidate({
    required this.geneId,
    required this.symbol,
    required this.description,
    required this.organism,
    this.summary,
  });
}

class NcbiGeneImportResult {
  final String geneId;
  final String symbol;
  final String description;
  final String organism;
  final String? summary;

  final String? refseqRnaAccession;
  final String? refseqProteinAccession;

  /// transcript 전체
  final String? nucleotideSequence;

  /// cloning용 CDS / ORF
  final String? cdsSequence;

  final String? proteinSequence;
  final List<String> pmids;

  const NcbiGeneImportResult({
    required this.geneId,
    required this.symbol,
    required this.description,
    required this.organism,
    this.summary,
    this.refseqRnaAccession,
    this.refseqProteinAccession,
    this.nucleotideSequence,
    this.cdsSequence,
    this.proteinSequence,
    this.pmids = const [],
  });
}