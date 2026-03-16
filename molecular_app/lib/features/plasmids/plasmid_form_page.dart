import 'package:flutter/material.dart';

class PlasmidFormPage extends StatefulWidget {
  const PlasmidFormPage({super.key});

  @override
  State<PlasmidFormPage> createState() => _PlasmidFormPageState();
}

class _PlasmidFormPageState extends State<PlasmidFormPage> {
  final TextEditingController plasmidNameController = TextEditingController();
  final TextEditingController insertGeneNameController = TextEditingController();
  final TextEditingController vectorNotesController = TextEditingController();

  bool restrictionDigestConfirmed = false;
  bool colonyPcrConfirmed = false;
  bool miniprepDone = false;
  bool insertSequenceVerified = false;

  @override
  void dispose() {
    plasmidNameController.dispose();
    insertGeneNameController.dispose();
    vectorNotesController.dispose();
    super.dispose();
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plasmid Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: plasmidNameController,
              decoration: const InputDecoration(
                labelText: 'Plasmid Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: insertGeneNameController,
              decoration: const InputDecoration(
                labelText: 'Insert Gene Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: vectorNotesController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Vector Notes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Restriction Digest Confirmed'),
              value: restrictionDigestConfirmed,
              onChanged: (value) {
                setState(() {
                  restrictionDigestConfirmed = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Colony PCR Confirmed'),
              value: colonyPcrConfirmed,
              onChanged: (value) {
                setState(() {
                  colonyPcrConfirmed = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Miniprep Done'),
              value: miniprepDone,
              onChanged: (value) {
                setState(() {
                  miniprepDone = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Insert Sequence Verified'),
              value: insertSequenceVerified,
              onChanged: (value) {
                setState(() {
                  insertSequenceVerified = value ?? false;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}