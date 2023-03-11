import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubValue', () {
    testWidgets('creates values correctly', (tester) async {
      final mock = MockBuilder<MockValue>();
      final wanted = MockValue();

      await tester.pumpWidget(
        SubValue(
          create: () => wanted,
          builder: mock,
        ),
      );

      expect(mock.single, wanted);
    });

    testWidgets('persists values over rebuilds', (tester) async {
      final mock = MockBuilder<MockValue>();
      final mock2 = MockBuilder<MockValue>();

      await tester.pumpWidget(
        SubValue(
          create: () => MockValue(),
          builder: mock,
        ),
      );

      await tester.pumpWidget(
        SubValue(
          create: () => MockValue(),
          builder: mock2,
        ),
      );

      expect(mock.single, mock2.single);

      final mock3 = MockBuilder<MockValue>();
      final mock4 = MockBuilder<MockValue>();

      await tester.pumpWidget(
        SubValue(
          create: () => MockValue(),
          builder: mock3,
        ),
      );

      await tester.pumpWidget(Container());

      await tester.pumpWidget(
        SubValue(
          create: () => MockValue(),
          builder: mock4,
        ),
      );

      expect(identical(mock3.last, mock4.last), isFalse);
    });

    testWidgets('recreates values when keys are changed', (tester) async {
      final mock = MockBuilder<MockValue>();
      MockValue key = MockValue();

      await tester.pumpWidget(
        SubValue(
          create: () => MockValue(),
          keys: [key],
          builder: mock,
        ),
      );
      key = MockValue();
      // rebuild with keys
      await tester.pumpWidget(
        SubValue(
          create: () => MockValue(),
          keys: [key],
          builder: mock,
        ),
      );

      expect(mock.args.length, 2);
      expect(identical(mock.first, mock.last), isFalse);
    });

    testWidgets('updates values with update callback', (tester) async {
      final obj = MockValue();
      final replacement = MockValue();
      final mock = MockBuilder<MockValue>();

      await tester.pumpWidget(
        SubValue(
          create: () => obj,
          builder: mock,
        ),
      );
      // rebuild with update
      await tester.pumpWidget(
        SubValue(
          create: () => obj,
          update: (previous) => replacement,
          builder: mock,
        ),
      );

      expect(mock.args.length, 2);
      expect(mock.first, obj);
      expect(mock.last, replacement);
    });

    testWidgets('disposes values when theyre not needed anymore',
        (tester) async {
      final dispose = DisposableMock();
      final dispose2 = DisposableMock();

      await tester.pumpWidget(
        SubValue<DisposableMock>(
          create: () => dispose,
          dispose: (value) => value.dispose(),
          builder: MockBuilder(),
        ),
      );

      expect(dispose.disposed, isFalse);

      await tester.pumpWidget(
        SubValue<DisposableMock>(
          create: () => dispose,
          update: (previous) => dispose2,
          dispose: (value) => value.dispose(),
          builder: MockBuilder(),
        ),
      );

      expect(dispose.disposed, isTrue);

      await tester.pumpWidget(Container());

      expect(dispose2.disposed, isTrue);
    });
  });
}
