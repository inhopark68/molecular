import 'package:flutter/material.dart';
import '../../database/app_database.dart';

class CloningFormPage extends StatelessWidget {
  final AppDatabase database;

  const CloningFormPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DNA Cloning')),
      body: const Center(
        child: Text('CloningFormPage placeholder'),
      ),
    );
  }
}