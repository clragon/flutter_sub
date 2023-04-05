import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubListener', () {
    testWidgets('calls its listener', (tester) async {
      final notifier = ValueNotifier(0);
      int counter = 0;

      await tester.pumpWidget(
        SubListener(
          listenable: notifier,
          listener: () => counter++,
          child: const SizedBox(),
        ),
      );

      expect(counter, 0);
      notifier.notifyListeners();
      expect(counter, 1);

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
          child: const SizedBox(),
        ),
      );

      expect(counter, 1);
    });

    testWidgets('throws if neither child nor builder are used', (tester) async {
      final notifier = ValueNotifier(0);
      int counter = 0;

      await tester.pumpWidget(
        // ignore: missing_required_param
        SubListener(
          initialize: true,
          listenable: notifier,
          listener: () => counter++,
        ),
      );

      expect(tester.takeException(), isAssertionError);
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
