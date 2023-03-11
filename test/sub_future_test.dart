import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubFuture', () {
    testWidgets('applies initial data', (tester) async {
      final mock = MockBuilder<AsyncSnapshot<int>>();
      const initial = 0;
      Future<int> future = Future.value(1);
      Widget builder(Future<int> future) => SubFuture(
            initialData: initial,
            preserveState: false,
            create: () => future,
            update: (_) => future,
            builder: mock,
          );

      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 0);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 1);
      future = Future.value(2);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 0);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 2);
    });

    testWidgets('keeps previous snapshot until new future is ready',
        (tester) async {
      final mock = MockBuilder<AsyncSnapshot<int>>();
      Future<int> future = Future.value(0);
      Widget builder(Future<int> future) => SubFuture(
            create: () => future,
            update: (_) => future,
            builder: mock,
          );

      await tester.pumpWidget(builder(future));
      expect(mock.last.data, null);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 0);

      future = Future.value(1);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 0);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 1);
    });

    testWidgets('passes empty snapshots when preserveState is false',
        (tester) async {
      final mock = MockBuilder<AsyncSnapshot<int>>();
      Future<int> future = Future.value(0);
      Widget builder(Future<int> future) => SubFuture(
            preserveState: false,
            create: () => future,
            update: (_) => future,
            builder: mock,
          );

      await tester.pumpWidget(builder(future));
      expect(mock.last.data, null);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 0);

      future = Future.value(1);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, null);
      await tester.pumpWidget(builder(future));
      expect(mock.last.data, 1);
    });
  });
}
