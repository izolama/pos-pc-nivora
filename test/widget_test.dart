import 'package:flutter_test/flutter_test.dart';

import 'package:pos_pc_nivora/app/app.dart';

void main() {
  testWidgets('renders POS dashboard shell', (WidgetTester tester) async {
    await tester.pumpWidget(const PosPcApp());
    await tester.pump();

    expect(find.text('DESAIN TABEL MASTER / ADMIN'), findsOneWidget);
    expect(find.text('Mr.Braid'), findsOneWidget);
    expect(find.text('POS PC / Admin Console'), findsOneWidget);
  });
}
