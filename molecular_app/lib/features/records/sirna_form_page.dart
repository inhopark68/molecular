import 'package:flutter/material.dart';
import '../../database/app_database.dart';

class SirnaFormPage extends StatelessWidget {
  final AppDatabase database;

  const SirnaFormPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('siRNA Treatment')),
      body: const Center(
        child: Text('SirnaFormPage placeholder'),
      ),
    );
  }
}