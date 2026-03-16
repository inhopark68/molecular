import 'dart:convert';

import 'package:http/http.dart' as http;

import 'addgene_parser.dart';

class AddgeneApiException implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  AddgeneApiException({
    required this.message,
    this.statusCode,
    this.cause,
  });

  @override
  String toString() {
    final code = statusCode == null ? '' : ' (status: $statusCode)';
    return 'AddgeneApiException$code: $message';
  }
}

class AddgeneSearchResult {
  final List<AddgenePlasmidImportData> items;
  final Map<String, dynamic>? raw;
  final String? nextPageToken;

  AddgeneSearchResult({
    required this.items,
    this.raw,
    this.nextPageToken,
  });
}

class AddgeneApi {
  /// 예:
  /// - 직접 호출: https://api.addgene.org
  /// - 백엔드 프록시: https://your-server.com/api/addgene
  final String baseUrl;

  /// Addgene 공식 토큰 또는 백엔드용 앱 토큰
  final String? bearerToken;

  final http.Client _client;

  AddgeneApi({
    required this.baseUrl,
    this.bearerToken,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Map<String, String> _headers() {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (bearerToken != null && bearerToken!.trim().isNotEmpty) {
      headers['Authorization'] = 'Bearer ${bearerToken!.trim()}';
    }

    return headers;
  }

  Uri _buildUri(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri.parse(baseUrl);
    final mergedPath = _mergePath(uri.path, path);

    return uri.replace(
      path: mergedPath,
      queryParameters: queryParameters?.map(
        (key, value) => MapEntry(key, value?.toString()),
      ),
    );
  }

  String _mergePath(String a, String b) {
    final left = a.endsWith('/') ? a.substring(0, a.length - 1) : a;
    final right = b.startsWith('/') ? b.substring(1) : b;

    if (left.isEmpty) return '/$right';
    return '$left/$right';
  }

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);

    final response = await _client.get(uri, headers: _headers());

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AddgeneApiException(
        message: 'Addgene API request failed',
        statusCode: response.statusCode,
        cause: response.body,
      );
    }

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw AddgeneApiException(
        message: 'Expected JSON object response',
        statusCode: response.statusCode,
        cause: decoded,
      );
    } catch (e) {
      throw AddgeneApiException(
        message: 'Failed to parse JSON response',
        statusCode: response.statusCode,
        cause: e,
      );
    }
  }

  /// Plasmid 검색
  ///
  /// path는 예시입니다.
  /// 실제 Addgene endpoint path 또는 프록시 path에 맞게 바꾸세요.
  ///
  /// 예:
  /// - /catalog/plasmids
  /// - /v1/plasmids
  /// - /search/plasmids
  Future<AddgeneSearchResult> searchPlasmids({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    final json = await _getJson(
      '/catalog/plasmids',
      queryParameters: {
        'q': query,
        'page': page,
        'page_size': pageSize,
      },
    );

    final rawItems = _extractItemList(json);
    final items = rawItems.map(AddgeneParser.fromJson).toList();

    return AddgeneSearchResult(
      items: items,
      raw: json,
      nextPageToken: _extractNextPageToken(json),
    );
  }

  /// Addgene ID로 단건 조회
  ///
  /// path는 예시입니다.
  /// 실제 endpoint가 다르면 '/catalog/plasmids/$addgeneId' 부분만 바꾸면 됩니다.
  Future<AddgenePlasmidImportData> getPlasmidByAddgeneId(
    String addgeneId,
  ) async {
    final normalized = addgeneId.trim();
    if (normalized.isEmpty) {
      throw AddgeneApiException(message: 'Addgene ID is empty');
    }

    final json = await _getJson('/catalog/plasmids/$normalized');

    final item = _extractSingleItem(json);
    return AddgeneParser.fromJson(item);
  }

  /// JSON bulk file 구조처럼 items/results/data 중 어디에 들어와도 대응
  List<Map<String, dynamic>> _extractItemList(Map<String, dynamic> json) {
    final candidates = [
      json['results'],
      json['items'],
      json['data'],
      json['plasmids'],
    ];

    for (final candidate in candidates) {
      if (candidate is List) {
        return candidate.whereType<Map<String, dynamic>>().toList();
      }
    }

    // 응답 자체가 단건일 때도 방어적으로 처리
    if (_looksLikeSinglePlasmid(json)) {
      return [json];
    }

    return const [];
  }

  Map<String, dynamic> _extractSingleItem(Map<String, dynamic> json) {
    if (_looksLikeSinglePlasmid(json)) {
      return json;
    }

    final items = _extractItemList(json);
    if (items.isNotEmpty) {
      return items.first;
    }

    throw AddgeneApiException(
      message: 'No plasmid item found in response',
      cause: json,
    );
  }

  bool _looksLikeSinglePlasmid(Map<String, dynamic> json) {
    return json.containsKey('plasmid_name') ||
        json.containsKey('name') ||
        json.containsKey('addgene_id') ||
        json.containsKey('plasmid_id');
  }

  String? _extractNextPageToken(Map<String, dynamic> json) {
    final candidates = [
      json['next_page_token'],
      json['next'],
      json['cursor'],
    ];

    for (final c in candidates) {
      if (c is String && c.trim().isNotEmpty) {
        return c.trim();
      }
    }
    return null;
  }

  void dispose() {
    _client.close();
  }
}