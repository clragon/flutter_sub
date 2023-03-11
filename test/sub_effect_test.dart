import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_effect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubEffect', () {
    testWidgets('calls the effect', (tester) async {
      bool wasCalled = false;

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            wasCalled = true;
            return null;
          },
          child: Container(),
        ),
      );

      expect(wasCalled, isTrue);
    });

    testWidgets('calls the effect every build when no keys are passed',
        (tester) async {
      int calls = 0;

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            calls++;
            return null;
          },
          child: Container(),
        ),
      );

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            calls++;
            return null;
          },
          child: Container(),
        ),
      );

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            calls++;
            return null;
          },
          child: Container(),
        ),
      );

      expect(calls, 3);
    });

    testWidgets('calls the effect once when keys are empty', (tester) async {
      int calls = 0;

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            calls++;
            return null;
          },
          keys: const [],
          child: Container(),
        ),
      );

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            calls++;
            return null;
          },
          keys: const [],
          child: Container(),
        ),
      );

      expect(calls, 1);
    });

    testWidgets('calls the effect when keys are changed', (tester) async {
      int calls = 0;

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            calls++;
            return null;
          },
          keys: const [],
          child: Container(),
        ),
      );

      await tester.pumpWidget(
        SubEffect(
          effect: () {
            calls++;
            return null;
          },
          keys: const [true],
          child: Container(),
        ),
      );

      expect(calls, 2);
    });
  });
}
