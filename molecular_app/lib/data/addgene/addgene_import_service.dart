import 'addgene_api.dart';
import 'addgene_parser.dart';
import '../database/app_database.dart';

class AddgeneImportService {
  final AddgeneApi api;
  final AppDatabase db;

  AddgeneImportService({
    required this.api,
    required this.db,
  });

  Future<List<AddgenePlasmidImportData>> search(String query) async {
    final result = await api.searchPlasmids(query: query);
    return result.items;
  }

  Future<int> importItem(AddgenePlasmidImportData item) {
    return db.importAddgenePlasmid(item);
  }

  Future<int> importByAddgeneId(String addgeneId) async {
    final item = await api.getPlasmidByAddgeneId(addgeneId);
    return db.importAddgenePlasmid(item);
  }
}