import 'package:flutter_test/flutter_test.dart';

import 'package:pos_pc_nivora/app/app.dart';

void main() {
  testWidgets('renders POS login shell', (WidgetTester tester) async {
    await tester.pumpWidget(const PosPcApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('POS PC NIVORA'), findsWidgets);
    expect(find.text('Login ke POS Service'), findsWidgets);
    expect(find.text('Login dan Masuk'), findsWidgets);
  });
}
