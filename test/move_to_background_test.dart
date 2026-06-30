import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:move_to_background/move_to_background.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('move_to_background');

  // Records every method call routed to the plugin channel so that tests can
  // assert on the invocation behaviour of [MoveToBackground.moveTaskToBack].
  final List<MethodCall> methodCalls = <MethodCall>[];

  // Installs a mock handler for the plugin channel. When [error] is provided
  // the handler throws it to simulate a native-side failure.
  void mockChannel({PlatformException? error}) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      methodCalls.add(methodCall);
      if (error != null) {
        throw error;
      }
      return null;
    });
  }

  setUp(() {
    methodCalls.clear();
    mockChannel();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('MoveToBackground.moveTaskToBack', () {
    test('should invoke the moveTaskToBack method on the channel', () async {
      await MoveToBackground.moveTaskToBack();

      expect(methodCalls, hasLength(1));
      expect(methodCalls.single.method, 'moveTaskToBack');
    });

    test('should not pass any arguments to the native side', () async {
      await MoveToBackground.moveTaskToBack();

      expect(methodCalls.single.arguments, isNull);
    });

    test('should complete normally when the native side returns void',
        () async {
      expect(MoveToBackground.moveTaskToBack(), completes);
    });

    test('should propagate PlatformException when UIAbility is not attached',
        () async {
      mockChannel(
        error: PlatformException(
          code: 'no_ability',
          message: 'UIAbility is not attached.',
        ),
      );

      await expectLater(
        MoveToBackground.moveTaskToBack(),
        throwsA(
          isA<PlatformException>()
              .having((PlatformException e) => e.code, 'code', 'no_ability'),
        ),
      );
    });

    test('should propagate PlatformException on a window error', () async {
      mockChannel(
        error: PlatformException(
          code: 'window_error',
          message: 'minimize failed.',
        ),
      );

      await expectLater(
        MoveToBackground.moveTaskToBack(),
        throwsA(
          isA<PlatformException>()
              .having((PlatformException e) => e.code, 'code', 'window_error'),
        ),
      );
    });

    test('should invoke the channel once per call on repeated calls',
        () async {
      await MoveToBackground.moveTaskToBack();
      await MoveToBackground.moveTaskToBack();
      await MoveToBackground.moveTaskToBack();

      expect(methodCalls, hasLength(3));
      expect(
        methodCalls.every((MethodCall call) => call.method == 'moveTaskToBack'),
        isTrue,
      );
    });

    test('should handle concurrent calls without losing invocations',
        () async {
      await Future.wait(<Future<void>>[
        MoveToBackground.moveTaskToBack(),
        MoveToBackground.moveTaskToBack(),
        MoveToBackground.moveTaskToBack(),
      ]);

      expect(methodCalls, hasLength(3));
    });
  });
}
