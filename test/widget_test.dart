import 'package:flutter_test/flutter_test.dart';
import 'package:anti_security_app/main.dart';

void main() {
  testWidgets(
    'Vehicle Security app loads',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const AntiSecurityApp(),
      );

      expect(
        find.text('ANTI SECURITY APP'),
        findsOneWidget,
      );
    },
  );
}