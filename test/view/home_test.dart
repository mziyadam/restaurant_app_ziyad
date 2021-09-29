import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/view/splash.dart';

void main() {
  testWidgets('Mengecek apakah saat dimulai akan menampilkan SplashPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.byType(SplashPage), findsOneWidget);
  });
}
