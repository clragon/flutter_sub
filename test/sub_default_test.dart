import 'package:flutter_sub/src/sub_default.dart';

import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubDefault', () {
    testWidgets('creates the default value when null is passed',
        (tester) async {
      final mock = MockBuilder<MockValue>();
      final value = MockValue();

      await tester.pumpWidget(
        SubDefault<MockValue>(
          value: null,
          create: () => value,
          builder: mock,
        ),
      );

      expect(mock.single, value);
    });

    testWidgets('disposes the default value when a non-null value is passed',
        (tester) async {
      final mock = MockBuilder<MockValue>();
      final value = MockValue();
      final defaultValue = MockValue();

      await tester.pumpWidget(
        SubDefault<MockValue>(
          value: null,
          create: () => defaultValue,
          dispose: (value) => value.dispose(),
          builder: mock,
        ),
      );

      expect(mock.single, defaultValue);

      await tester.pumpWidget(
        SubDefault<MockValue>(
          value: value,
          create: () => defaultValue,
          dispose: (value) => value.dispose(),
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 2);
      expect(mock.first, defaultValue);
      expect(mock.last, value);
      expect(defaultValue.disposed, true);
    });

    testWidgets('uses the passed value when non-null is passed',
        (tester) async {
      final mock = MockBuilder<MockValue>();
      final value = MockValue();
      final defaultValue = MockValue();

      await tester.pumpWidget(
        SubDefault<MockValue>(
          value: value,
          create: () => defaultValue,
          builder: mock,
        ),
      );

      expect(mock.single, value);
    });

    testWidgets('does not dispose the passed value', (tester) async {
      final mock = MockBuilder<MockValue>();
      final value = MockValue();

      await tester.pumpWidget(
        SubDefault<MockValue>(
          value: value,
          create: () => MockValue(),
          dispose: (value) => value.dispose(),
          builder: mock,
        ),
      );

      expect(mock.single, value);

      await tester.pumpWidget(
        SubDefault<MockValue>(
          value: null,
          create: () => MockValue(),
          dispose: (value) => value.dispose(),
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 2);
      expect(value.disposed, false);
    });
  });
}
