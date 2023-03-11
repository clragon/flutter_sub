import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubValueListener', () {
    testWidgets('calls its listener and builder', (tester) async {
      final mock = MockBuilder<int>();
      final notifier = ValueNotifier(0);
      int? out;

      await tester.pumpWidget(
        SubValueListener<int>(
          listenable: notifier,
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, null);
      expect(mock.last, 0);

      notifier.value = 1;
      await tester.pumpWidget(
        SubValueListener<int>(
          listenable: notifier,
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, 1);
      expect(mock.last, 1);
    });

    testWidgets('calls listener initially if initialize is true',
        (tester) async {
      final mock = MockBuilder<int>();
      final notifier = ValueNotifier(0);
      int? out;

      await tester.pumpWidget(
        SubValueListener<int>(
          initialize: true,
          listenable: notifier,
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, 0);
      expect(mock.last, 0);
    });
  });

  group('SubValueNotifier', () {
    testWidgets('uses initialData correctly', (tester) async {
      final mock = MockBuilder<ValueNotifier<int>>();
      const initial = 42;

      await tester.pumpWidget(
        SubValueNotifier<int>(
          initialData: initial,
          builder: mock,
        ),
      );

      expect(mock.last.value, initial);
    });
    testWidgets('calls its builder when notified', (tester) async {
      final mock = MockBuilder<ValueNotifier<int>>();

      await tester.pumpWidget(
        SubValueNotifier<int>(
          initialData: 0,
          builder: mock,
        ),
      );

      expect(mock.last.value, 0);

      mock.last.value = 1;
      await tester.pumpWidget(
        SubValueNotifier<int>(
          initialData: 0,
          builder: mock,
        ),
      );

      expect(mock.last.value, 1);
    });
  });
}
