import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_test_riverpod/screens/homepage.dart';

void main() {
  group('Homepage tests', () {
    testWidgets('All navigation elements exist', (tester) async {
      Widget homepageWidget = const HomepageWidget(email: 'test@test.com',);
      await tester.pumpWidget(MaterialApp(
        home: homepageWidget,
      ));

      final newRunButton = find.ancestor(of: find.byIcon(Icons.library_add), matching: find.byWidgetPredicate((widget) => widget is IconButton));
      final showSavedCoords = find.ancestor(of: find.byIcon(Icons.list_alt), matching: find.byWidgetPredicate((widget) => widget is IconButton));

      expect(newRunButton, findsOneWidget);
      expect(showSavedCoords, findsOneWidget);
    });
  });
}
