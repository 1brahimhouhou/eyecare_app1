import 'package:flutter_test/flutter_test.dart';
import 'package:code_eyecare/main.dart';

void main() {
  testWidgets('App boots to Login screen', (WidgetTester tester) async {
    // شغّل الأبّل
    await tester.pumpWidget(const BabiVisionApp());
    await tester.pumpAndSettle();

    // تأكّد من وجود عنوان Login
    expect(find.text('Login'), findsOneWidget);
  });
}

