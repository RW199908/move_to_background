// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:move_to_background_example/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('move_to_background');
  final List<MethodCall> methodCalls = <MethodCall>[];

  setUp(() {
    methodCalls.clear();
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      methodCalls.add(methodCall);
      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  testWidgets('renders the current example screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(WillPopScope), findsOneWidget);
    expect(find.text('MoveToBackground Example'), findsOneWidget);
    expect(find.text('Press the floating action button'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('tapping the floating action button invokes moveTaskToBack', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(methodCalls, hasLength(1));
    expect(methodCalls.single.method, 'moveTaskToBack');
  });

  testWidgets('back interception blocks pop and invokes moveTaskToBack', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp());

    final WillPopScope willPopScope = tester.widget<WillPopScope>(
      find.byType(WillPopScope),
    );
    final bool? shouldPop = await willPopScope.onWillPop?.call();

    expect(shouldPop, isFalse);
    expect(
      methodCalls.map((MethodCall methodCall) => methodCall.method),
      contains('moveTaskToBack'),
    );
  });
}
