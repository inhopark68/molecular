import 'package:flutter/material.dart';

import '../../data/database/app_database.dart';

class PlasmidPickerDialog extends StatefulWidget {
  final AppDatabase db;
  final String title;

  const PlasmidPickerDialog({
    super.key,
    required this.db,
    this.title = 'Select plasmid from inventory',
  });

  @override
  State<PlasmidPickerDialog> createState() => _PlasmidPickerDialogState();
}

class _PlasmidPickerDialogState extends State<PlasmidPickerDialog> {
  final TextEditingController _searchController = TextEditingController();

  bool _isLoading = false;
  String? _error;
  List<Plasmid> _items = [];

  @override
  void initState() {
    super.initState();
    _search();
  }

  Future<void> _search() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await widget.db.searchSelectablePlasmids(
        _searchController.text,
      );

      if (!mounted) return;

      setState(() {
        _items = result;
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

  Widget _buildInfoChip(String label, String? value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        '$label: ${value?.isNotEmpty == true ? value : '-'}',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildCard(Plasmid plasmid) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.of(context).pop(plasmid),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plasmid.plasmidName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'ID: ${plasmid.id}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildInfoChip('Alias', plasmid.alias),
                  _buildInfoChip('Addgene ID', plasmid.addgeneId),
                  _buildInfoChip('Backbone', plasmid.backbone),
                  _buildInfoChip('Insert', plasmid.insertGene),
                  _buildInfoChip('Promoter', plasmid.promoter),
                  _buildInfoChip('Tag', plasmid.tag),
                  _buildInfoChip('Antibiotic', plasmid.bacterialAntibiotic),
                  _buildInfoChip('Ori', plasmid.ori),
                  _buildInfoChip(
                    'Size',
                    plasmid.sizeBp == null ? null : '${plasmid.sizeBp} bp',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(plasmid),
                  child: const Text('Select'),
                ),
              ),
            ],
          ),
        ),
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
      title: Text(widget.title),
      content: SizedBox(
        width: 860,
        height: 560,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by plasmid name, alias, Addgene ID...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => _search(),
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
                child: Center(child: CircularProgressIndicator()),
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
            else if (_items.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('No plasmids found'),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (_, index) => _buildCard(_items[index]),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}