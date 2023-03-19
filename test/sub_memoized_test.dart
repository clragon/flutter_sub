import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubMemoized', () {
    testWidgets('caches and recreates its value based on keys', (tester) async {
      final mock = MockBuilder<MockValue>();

      await tester.pumpWidget(
        SubMemoized(
          create: () => MockValue(),
          builder: mock,
        ),
      );

      await tester.pumpWidget(
        SubMemoized(
          create: () => MockValue(),
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 1);

      await tester.pumpWidget(
        SubMemoized(
          create: () => MockValue(),
          keys: const [true],
          builder: mock,
        ),
      );

      expect(mock.uargs.length, 2);
    });
  });
}
