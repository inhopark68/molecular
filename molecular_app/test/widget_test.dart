import 'package:flutter_test/flutter_test.dart';
import 'package:molecular_work_app/main.dart';

void main() {
  testWidgets('home page renders app title', (tester) async {
    await tester.pumpWidget(const MolecularWorkApp());

    expect(find.text('Molecular Work App'), findsOneWidget);
    expect(find.text('DNA Cloning'), findsOneWidget);
  });
}
