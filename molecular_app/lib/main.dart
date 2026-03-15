import 'package:flutter/material.dart';

import 'database/app_database.dart';
import 'features/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({
    super.key,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Molecular Work App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: HomePage(database: database),
    );
  }
}