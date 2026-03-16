import 'package:flutter/material.dart';

import '../../data/addgene/addgene_api.dart';
import '../../data/addgene/addgene_parser.dart';
import '../../data/database/app_database.dart';

class AddgeneSearchDialog extends StatefulWidget {
  final AddgeneApi addgeneApi;
  final AppDatabase db;

  const AddgeneSearchDialog({
    super.key,
    required this.addgeneApi,
    required this.db,
  });

  @override
  State<AddgeneSearchDialog> createState() => _AddgeneSearchDialogState();
}

class _AddgeneSearchDialogState extends State<AddgeneSearchDialog> {
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  bool _isImporting = false;
  String? _error;

  List<AddgenePlasmidImportData> _results = [];

  Future<void> _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _results = [];
    });

    try {
      final result = await widget.addgeneApi.searchPlasmids(query: query);

      if (!mounted) return;

      setState(() {
        _results = result.items;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString();
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _importPlasmid(AddgenePlasmidImportData item) async {
    setState(() {
      _isImporting = true;
      _error = null;
    });

    try {
      final plasmidId = await widget.db.importAddgenePlasmid(item);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Imported to inventory: ${item.plasmidName} (ID: $plasmidId)',
          ),
        ),
      );

      Navigator.of(context).pop(plasmidId);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString();
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _isImporting = false;
      });
    }
  }

  Widget _buildResultCard(AddgenePlasmidImportData item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.plasmidName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _infoChip('Alias', item.alias),
                _infoChip('Addgene ID', item.addgeneId),
                _infoChip('Backbone', item.backbone),
                _infoChip('Insert', item.insertGene),
                _infoChip('Promoter', item.promoter),
                _infoChip('Tag', item.tag),
                _infoChip('Antibiotic', item.bacterialAntibiotic),
                _infoChip('Ori', item.ori),
                _infoChip(
                  'Size',
                  item.sizeBp == null ? null : '${item.sizeBp} bp',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _isImporting ? null : () => _importPlasmid(item),
                icon: const Icon(Icons.download),
                label: const Text('Import to Inventory'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String label, String? value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        '$label: ${value?.isNotEmpty == true ? value : '-'}',
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Import plasmid from Addgene'),
      content: SizedBox(
        width: 820,
        height: 560,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by plasmid name or Addgene ID',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _search,
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (_error != null)
              Expanded(
                child: Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else if (_results.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('No results yet'),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (_, index) {
                    final item = _results[index];
                    return _buildResultCard(item);
                  },
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isImporting ? null : () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}