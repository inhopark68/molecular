class AddgenePlasmidImportData {
  final String plasmidName;
  final String? alias;
  final String? addgeneId;
  final String? backbone;
  final String? insertGene;
  final String? promoter;
  final String? tag;
  final String? bacterialAntibiotic;
  final String? mammalianSelection;
  final String? ori;
  final int? sizeBp;
  final String? genbankUrl;
  final String? snapgeneUrl;
  final String? notes;

  AddgenePlasmidImportData({
    required this.plasmidName,
    this.alias,
    this.addgeneId,
    this.backbone,
    this.insertGene,
    this.promoter,
    this.tag,
    this.bacterialAntibiotic,
    this.mammalianSelection,
    this.ori,
    this.sizeBp,
    this.genbankUrl,
    this.snapgeneUrl,
    this.notes,
  });
}

class AddgeneParser {
  static AddgenePlasmidImportData fromJson(Map<String, dynamic> json) {
    final plasmidName = _firstString(
          json,
          [
            'plasmid_name',
            'name',
            'display_name',
            'title',
          ],
        ) ??
        'Unknown plasmid';

    final alias = _firstString(
      json,
      [
        'alias',
        'short_name',
        'plasmid_alias',
      ],
    );

    final addgeneId = _normalizeString(
      _firstString(
        json,
        [
          'addgene_id',
          'plasmid_id',
          'id',
          'catalog_number',
          'addgene_number',
        ],
      ),
    );

    final backbone = _firstStringDeep(
      json,
      [
        ['backbone'],
        ['vector', 'backbone'],
        ['vector_details', 'backbone'],
        ['vector', 'name'],
      ],
    );

    final insertGene = _extractInsertGene(json);
    final promoter = _extractPromoter(json);
    final tag = _extractTag(json);
    final bacterialAntibiotic = _extractBacterialAntibiotic(json);
    final mammalianSelection = _extractMammalianSelection(json);
    final ori = _extractOri(json);

    final sizeBp = _firstInt(
      json,
      [
        'size_bp',
        'plasmid_size_bp',
        'sequence_length',
        'length_bp',
      ],
    );

    final genbankUrl = _firstStringDeep(
      json,
      [
        ['files', 'genbank_url'],
        ['sequence', 'genbank_url'],
        ['downloads', 'genbank'],
        ['genbank_url'],
      ],
    );

    final snapgeneUrl = _firstStringDeep(
      json,
      [
        ['files', 'snapgene_url'],
        ['sequence', 'snapgene_url'],
        ['downloads', 'snapgene'],
        ['snapgene_url'],
      ],
    );

    final notes = _buildNotes(json);

    return AddgenePlasmidImportData(
      plasmidName: plasmidName,
      alias: alias,
      addgeneId: addgeneId,
      backbone: backbone,
      insertGene: insertGene,
      promoter: promoter,
      tag: tag,
      bacterialAntibiotic: bacterialAntibiotic,
      mammalianSelection: mammalianSelection,
      ori: ori,
      sizeBp: sizeBp,
      genbankUrl: genbankUrl,
      snapgeneUrl: snapgeneUrl,
      notes: notes,
    );
  }

  static String? _extractInsertGene(Map<String, dynamic> json) {
    final direct = _firstString(
      json,
      ['insert_gene', 'gene', 'insert', 'gene_name'],
    );
    if (direct != null) return direct;

    final genes = json['genes'];
    if (genes is List && genes.isNotEmpty) {
      final names = genes
          .map((e) {
            if (e is Map<String, dynamic>) {
              return _firstString(e, ['name', 'symbol', 'gene_name']);
            }
            return null;
          })
          .whereType<String>()
          .where((e) => e.trim().isNotEmpty)
          .toList();

      if (names.isNotEmpty) {
        return names.join(', ');
      }
    }

    return null;
  }

  static String? _extractPromoter(Map<String, dynamic> json) {
    final direct = _firstString(
      json,
      ['promoter', 'promoters'],
    );
    if (direct != null) return direct;

    final expression = json['expression'];
    if (expression is Map<String, dynamic>) {
      final promoter = _firstString(expression, ['promoter', 'promoters']);
      if (promoter != null) return promoter;
    }

    final annotations = json['annotations'];
    if (annotations is List) {
      final promoterHits = annotations
          .map((e) => e is Map<String, dynamic>
              ? _firstString(e, ['label', 'name', 'feature'])
              : null)
          .whereType<String>()
          .where((e) =>
              e.toLowerCase().contains('promoter') ||
              e.toUpperCase().contains('CMV') ||
              e.toUpperCase().contains('EF1') ||
              e.toUpperCase().contains('U6') ||
              e.toUpperCase().contains('SV40') ||
              e.toUpperCase().contains('T7'))
          .toList();

      if (promoterHits.isNotEmpty) {
        return promoterHits.first;
      }
    }

    return null;
  }

  static String? _extractTag(Map<String, dynamic> json) {
    final direct = _firstString(
      json,
      ['tag', 'tags'],
    );
    if (direct != null) return direct;

    final tags = json['tags'];
    if (tags is List) {
      final names = tags
          .map((e) {
            if (e is Map<String, dynamic>) {
              return _firstString(e, ['name', 'label']);
            }
            if (e is String) return e;
            return null;
          })
          .whereType<String>()
          .where((e) => e.trim().isNotEmpty)
          .toList();

      if (names.isNotEmpty) {
        return names.join(', ');
      }
    }

    final annotations = json['annotations'];
    if (annotations is List) {
      final tagHits = annotations
          .map((e) => e is Map<String, dynamic>
              ? _firstString(e, ['label', 'name', 'feature'])
              : null)
          .whereType<String>()
          .where((e) =>
              e.toUpperCase().contains('GFP') ||
              e.toUpperCase().contains('FLAG') ||
              e.toUpperCase().contains('HA') ||
              e.toUpperCase().contains('MYC') ||
              e.toUpperCase().contains('MCHERRY'))
          .toList();

      if (tagHits.isNotEmpty) {
        return tagHits.first;
      }
    }

    return null;
  }

  static String? _extractBacterialAntibiotic(Map<String, dynamic> json) {
    final direct = _firstString(
      json,
      [
        'bacterial_antibiotic',
        'bacterial_selection',
        'selection_marker',
      ],
    );
    if (direct != null) return direct;

    final vector = json['vector'];
    if (vector is Map<String, dynamic>) {
      final value = _firstString(
        vector,
        ['bacterial_selection', 'antibiotic', 'selection_marker'],
      );
      if (value != null) return value;
    }

    final annotations = json['annotations'];
    if (annotations is List) {
      for (final item in annotations) {
        if (item is! Map<String, dynamic>) continue;
        final label = _firstString(item, ['label', 'name', 'feature']);
        if (label == null) continue;

        final upper = label.toUpperCase();
        if (upper.contains('AMPR') || upper.contains('BLA')) {
          return 'Ampicillin';
        }
        if (upper.contains('KANR')) {
          return 'Kanamycin';
        }
        if (upper.contains('CMR') || upper.contains('CAT')) {
          return 'Chloramphenicol';
        }
        if (upper.contains('SPECR')) {
          return 'Spectinomycin';
        }
        if (upper.contains('TETR')) {
          return 'Tetracycline';
        }
      }
    }

    return null;
  }

  static String? _extractMammalianSelection(Map<String, dynamic> json) {
    final direct = _firstString(
      json,
      [
        'mammalian_selection',
        'mammalian_marker',
        'selection_mammalian',
      ],
    );
    if (direct != null) return direct;

    final annotations = json['annotations'];
    if (annotations is List) {
      for (final item in annotations) {
        if (item is! Map<String, dynamic>) continue;
        final label = _firstString(item, ['label', 'name', 'feature']);
        if (label == null) continue;

        final upper = label.toUpperCase();
        if (upper.contains('PUROR') || upper.contains('PURO')) {
          return 'Puromycin';
        }
        if (upper.contains('HYGR') || upper.contains('HYGRO')) {
          return 'Hygromycin';
        }
        if (upper.contains('NEOR') || upper.contains('G418')) {
          return 'G418';
        }
        if (upper.contains('BSDR') || upper.contains('BLASTICIDIN')) {
          return 'Blasticidin';
        }
      }
    }

    return null;
  }

  static String? _extractOri(Map<String, dynamic> json) {
    final direct = _firstString(
      json,
      ['ori', 'origin', 'origin_of_replication'],
    );
    if (direct != null) return direct;

    final vector = json['vector'];
    if (vector is Map<String, dynamic>) {
      final value = _firstString(
        vector,
        ['ori', 'origin', 'origin_of_replication'],
      );
      if (value != null) return value;
    }

    final annotations = json['annotations'];
    if (annotations is List) {
      final oriHits = annotations
          .map((e) => e is Map<String, dynamic>
              ? _firstString(e, ['label', 'name', 'feature'])
              : null)
          .whereType<String>()
          .where((e) {
            final upper = e.toUpperCase();
            return upper.contains('ORI') ||
                upper.contains('COLE1') ||
                upper.contains('PUC') ||
                upper.contains('PMB1') ||
                upper.contains('F1');
          })
          .toList();

      if (oriHits.isNotEmpty) {
        return oriHits.first;
      }
    }

    return null;
  }

  static String? _buildNotes(Map<String, dynamic> json) {
    final purpose = _firstString(json, ['purpose', 'summary', 'description']);
    final depositor = _firstStringDeep(
      json,
      [
        ['depositor', 'name'],
        ['depositing_lab', 'name'],
        ['lab', 'name'],
      ],
    );

    final pieces = <String>[];
    if (purpose != null && purpose.isNotEmpty) {
      pieces.add('Purpose: $purpose');
    }
    if (depositor != null && depositor.isNotEmpty) {
      pieces.add('Depositor: $depositor');
    }

    if (pieces.isEmpty) return null;
    return pieces.join(' | ');
  }

  static String? _firstString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      final normalized = _normalizeString(value);
      if (normalized != null) return normalized;
    }
    return null;
  }

  static String? _firstStringDeep(
    Map<String, dynamic> json,
    List<List<String>> paths,
  ) {
    for (final path in paths) {
      dynamic current = json;
      for (final key in path) {
        if (current is Map<String, dynamic>) {
          current = current[key];
        } else {
          current = null;
          break;
        }
      }
      final normalized = _normalizeString(current);
      if (normalized != null) return normalized;
    }
    return null;
  }

  static int? _firstInt(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is int) return value;
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) return parsed;
      }
    }
    return null;
  }

  static String? _normalizeString(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      final trimmed = value.trim();
      return trimmed.isEmpty ? null : trimmed;
    }
    final stringValue = value.toString().trim();
    return stringValue.isEmpty ? null : stringValue;
  }
}