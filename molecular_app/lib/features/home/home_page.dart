import 'package:flutter/material.dart';
import 'package:molecular_work_app/database/app_database.dart';
import 'package:molecular_work_app/features/cell_lines/cell_line_list_page.dart';
import 'package:molecular_work_app/features/plasmids/plasmid_list_page.dart';
import 'package:molecular_work_app/features/records/cloning_form_page.dart';
import 'package:molecular_work_app/features/records/experiment_form_page.dart';
import 'package:molecular_work_app/features/records/experiment_list_page.dart';
import 'package:molecular_work_app/features/records/purification_form_page.dart';
import 'package:molecular_work_app/features/records/sirna_form_page.dart';
import 'package:molecular_work_app/features/records/transfection_form_page.dart';

class HomePage extends StatelessWidget {
  final AppDatabase database;

  const HomePage({
    super.key,
    required this.database,
  });

  static const List<String> _modules = [
    'DNA Cloning',
    'Transformation',
    'Plasmid Prep',
    'Transfection',
    'Cell Selection',
    'siRNA Treatment',
    'Protein Purification',
  ];

  void _openModulePage(BuildContext context, String module) {
    Widget page;

    switch (module) {
      case 'DNA Cloning':
        page = CloningFormPage(database: database);
        break;
      case 'Transfection':
        page = TransfectionFormPage(database: database);
        break;
      case 'siRNA Treatment':
        page = SirnaFormPage(database: database);
        break;
      case 'Protein Purification':
        page = PurificationFormPage(database: database);
        break;
      default:
        page = ExperimentFormPage(
          database: database,
          module: module,
        );
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void _openExperimentList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExperimentListPage(database: database),
      ),
    );
  }

  void _openPlasmidList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlasmidListPage(database: database),
      ),
    );
  }

  void _openCellLineList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CellLineListPage(database: database),
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, String module) {
    return Card(
      child: ListTile(
        title: Text(module),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openModulePage(context, module),
      ),
    );
  }

  Widget _buildInventoryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Molecular Work App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '실험 모듈',
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          ..._modules.map((module) => _buildModuleCard(context, module)),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _openExperimentList(context),
            icon: const Icon(Icons.list_alt),
            label: const Text('저장된 기록 보기'),
          ),
          const SizedBox(height: 28),
          Text(
            '인벤토리',
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          _buildInventoryCard(
            context: context,
            icon: Icons.inventory_2_outlined,
            title: 'Plasmids',
            onTap: () => _openPlasmidList(context),
          ),
          _buildInventoryCard(
            context: context,
            icon: Icons.biotech,
            title: 'Cell Lines',
            onTap: () => _openCellLineList(context),
          ),
        ],
      ),
    );
  }
}