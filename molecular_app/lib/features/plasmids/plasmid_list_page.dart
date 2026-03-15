import 'package:flutter/material.dart';
import '../../database/app_database.dart';

class PlasmidListPage extends StatelessWidget {
  final AppDatabase database;

  const PlasmidListPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plasmids')),
      body: const Center(
        child: Text('PlasmidListPage placeholder'),
      ),
    );
  }
}