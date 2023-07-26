import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubListener', () {
    testWidgets('calls its listener', (tester) async {
      final builder = MockBuilder<int>();
      final notifier = ValueNotifier(0);
      int counter = 0;

      await tester.pumpWidget(
        SubListener(
          listenable: notifier,
          listener: () => counter++,
          builder: (context) => builder(context, counter),
        ),
      );

      expect(counter, 0);
      expect(builder.last, 0);
      notifier.notifyListeners();

      await tester.pumpWidget(
        SubListener(
          listenable: notifier,
          listener: () => counter++,
          builder: (context) => builder(context, counter),
        ),
      );

      expect(counter, 1);
      expect(builder.last, 1);

      await tester.pumpWidget(Container());

      notifier.notifyListeners();
      expect(counter, 1);
    });

    testWidgets('calls listener initially if initialize is true',
        (tester) async {
      final notifier = ValueNotifier(0);
      int counter = 0;

      await tester.pumpWidget(
        SubListener(
          initialize: true,
          listenable: notifier,
          listener: () => counter++,
          builder: (context) => const SizedBox(),
        ),
      );

      expect(counter, 1);
    });

    testWidgets('updates listener callback when updated', (tester) async {
      final notifier = ValueNotifier(0);
      int counter = 0;

      await tester.pumpWidget(
        SubListener(
          listenable: notifier,
          listener: () => counter++,
          builder: (context) => const SizedBox(),
        ),
      );

      notifier.notifyListeners();
      expect(counter, 1);

      int newCounter = 0;
      await tester.pumpWidget(
        SubListener(
          listenable: notifier,
          listener: () => newCounter++,
          builder: (context) => const SizedBox(),
        ),
      );

      notifier.notifyListeners();
      await tester.pump();
      expect(counter, 1);
      expect(newCounter, 1);
    });
  });

  group('SubDisposableListenable', () {
    testWidgets('disposes its ChangeNotifier', (tester) async {
      final notifier = ValueNotifier(0);

      await tester.pumpWidget(
        _MockSubDisposableListenable<ValueNotifier<int>>(
          create: () => notifier,
          builder: MockBuilder(),
        ),
      );

      await tester.pumpWidget(Container());

      expect(() => notifier.addListener(() {}), throwsFlutterError);
    });
  });
}

class _MockSubDisposableListenable<T extends ChangeNotifier>
    extends SubDisposableListenable<T> {
  _MockSubDisposableListenable({
    required super.create,
    required super.builder,
  });
}
