import 'package:flutter/material.dart';
import '../../database/app_database.dart';

class CellLineListPage extends StatelessWidget {
  final AppDatabase database;

  const CellLineListPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cell Lines')),
      body: const Center(
        child: Text('CellLineListPage placeholder'),
      ),
    );
  }
}