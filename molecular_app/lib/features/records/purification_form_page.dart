import 'package:flutter/material.dart';
import '../../database/app_database.dart';

class PurificationFormPage extends StatelessWidget {
  final AppDatabase database;

  const PurificationFormPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Protein Purification')),
      body: const Center(
        child: Text('PurificationFormPage placeholder'),
      ),
    );
  }
}