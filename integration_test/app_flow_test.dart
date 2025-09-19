import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kabtour_social_offline/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('basic navigation buttons present', (tester) async {
    await app.main();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('fabCreate')), findsOneWidget);
    expect(find.byKey(const Key('manageButton')), findsOneWidget);
  });
}
