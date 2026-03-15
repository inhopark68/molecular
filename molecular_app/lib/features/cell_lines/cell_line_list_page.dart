import 'package:flutter/material.dart';
import 'package:molecular_work_app/database/app_database.dart';
import 'package:molecular_work_app/features/cell_lines/cell_line_form_page.dart';

class CellLineListPage extends StatelessWidget {
  final AppDatabase database;

  const CellLineListPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cell Lines'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CellLineFormPage(database: database),
            ),
          );
        },
      ),
      body: StreamBuilder<List<CellLine>>(
        stream: database.watchAllCellLines(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final cellLines = snapshot.data!;

          if (cellLines.isEmpty) {
            return const Center(
              child: Text('No cell lines yet'),
            );
          }

          return ListView.builder(
            itemCount: cellLines.length,
            itemBuilder: (context, index) {
              final cell = cellLines[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.science),
                  title: Text(cell.cellLineName),
                  subtitle: Text(cell.updatedAt.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}