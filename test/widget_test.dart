import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paise_wala/main.dart';

void main() {
  testWidgets('Paise Wala home renders core dashboard', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainShell(),
      ),
    );

    expect(find.text('Paise Wala'), findsOneWidget);
    expect(find.text('Hi, welcome! 👋'), findsOneWidget);
    expect(find.text('Quick actions'), findsOneWidget);
    expect(find.text('Earn'), findsOneWidget);
  });

  testWidgets('bottom navigation opens wallet screen', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MainShell(),
      ),
    );

    await tester.tap(find.text('Wallet').last);
    await tester.pumpAndSettle();

    expect(find.text('Your demo rewards overview'), findsOneWidget);
  });
}
