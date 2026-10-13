// Basic Flutter widget test for FixIt Repair Shop App.

import 'package:flutter_test/flutter_test.dart';

import 'package:fixit/main.dart';

void main() {
  testWidgets('RepairShopApp loads home screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RepairShopApp());

    // Verify that the home page displays expected app content.
    expect(find.text('FixIt Support'), findsOneWidget);
    expect(find.text('Screen Replace'), findsOneWidget);
  });
}
