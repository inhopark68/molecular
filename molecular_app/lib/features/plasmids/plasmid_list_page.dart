import 'package:flutter/material.dart';

import '../../database/app_database.dart';
import 'plasmid_form_page.dart';

class PlasmidListPage extends StatelessWidget {
  final AppDatabase database;

  const PlasmidListPage({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plasmids'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlasmidFormPage(),
            ),
          );
        },
      ),
      body: StreamBuilder<List<Plasmid>>(
        stream: database.watchAllPlasmids(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final plasmids = snapshot.data!;

          if (plasmids.isEmpty) {
            return const Center(
              child: Text("No plasmids yet"),
            );
          }

          return ListView.builder(
            itemCount: plasmids.length,
            itemBuilder: (context, index) {
              final plasmid = plasmids[index];

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.biotech),
                  title: Text(plasmid.plasmidName),
                  subtitle: Text(
                    plasmid.updatedAt.toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}