// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:starter_app/main.dart';

void main() {
  testWidgets('Task list smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our initial tasks are shown.
    expect(find.text('Welcome to the demo app!'), findsOneWidget);
    expect(find.text('Add your first task'), findsOneWidget);

    // Tap the '+' icon to add a task.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Now on add task screen, enter text and add.
    await tester.enterText(find.byType(TextField), 'New Task');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Verify that the new task is added.
    expect(find.text('New Task'), findsOneWidget);
  });
}