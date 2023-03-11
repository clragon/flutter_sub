import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubMemo', () {
    testWidgets('caches and recreates its value based on keys', (tester) async {
      final mock = MockBuilder<MockValue>();

      await tester.pumpWidget(
        SubMemo(
          create: () => MockValue(),
          builder: mock,
        ),
      );

      await tester.pumpWidget(
        SubMemo(
          create: () => MockValue(),
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 1);

      await tester.pumpWidget(
        SubMemo(
          create: () => MockValue(),
          keys: const [true],
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 2);
    });
  });

  group('SubCallback', () {
    testWidgets('caches and recreates its value based on keys', (tester) async {
      final mock = MockBuilder<Function>();

      await tester.pumpWidget(
        SubCallback(
          callback: () => null,
          builder: mock,
        ),
      );

      await tester.pumpWidget(
        SubCallback(
          callback: () => null,
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 1);

      await tester.pumpWidget(
        SubCallback(
          callback: () => null,
          keys: const [true],
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 2);
    });
  });
}
