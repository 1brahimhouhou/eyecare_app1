import 'package:flutter_test/flutter_test.dart';
import 'package:eyecare_app/main.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(const EyeCareApp());
    await tester.pumpAndSettle();
  });
}
