import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubStream', () {
    testWidgets('applies initial data', (tester) async {
      final mock = MockBuilder<AsyncSnapshot<int>>();
      const initial = 0;
      Stream<int> stream = Stream.value(1);
      Widget builder(Stream<int> stream) => SubStream(
            initialData: initial,
            preserveState: false,
            create: () => stream,
            update: (_) => stream,
            builder: mock,
          );

      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 0);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 1);
      stream = Stream.value(2);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 0);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 2);
    });

    testWidgets('keeps previous snapshot until new stream is ready',
        (tester) async {
      final mock = MockBuilder<AsyncSnapshot<int>>();
      Stream<int> stream = Stream.value(0);
      Widget builder(Stream<int> stream) => SubStream(
            create: () => stream,
            update: (_) => stream,
            builder: mock,
          );

      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, null);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 0);

      stream = Stream.value(1);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 0);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 1);
    });

    testWidgets('passes empty snapshots when preserveState is false',
        (tester) async {
      final mock = MockBuilder<AsyncSnapshot<int>>();
      Stream<int> stream = Stream.value(0);
      Widget builder(Stream<int> stream) => SubStream(
            preserveState: false,
            create: () => stream,
            update: (_) => stream,
            builder: mock,
          );

      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, null);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 0);

      stream = Stream.value(1);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, null);
      await tester.pumpWidget(builder(stream));
      expect(mock.last.data, 1);
    });
  });

  group('SubStreamController', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<StreamController>();

      bool sync = true;
      void onListen() {}
      void onCancel() {}

      await tester.pumpWidget(
        SubStreamController(
          sync: sync,
          onCancel: onCancel,
          onListen: onListen,
          builder: mock,
        ),
      );

      expect(mock.last is SynchronousStreamController, isTrue);
      expect(mock.last.onListen, onListen);
      expect(mock.last.onCancel, onCancel);
    });

    testWidgets('is disposed correctly', (tester) async {
      final mock = MockBuilder<StreamController>();

      await tester.pumpWidget(
        SubStreamController(
          builder: mock,
        ),
      );

      expect(mock.last.isClosed, isFalse);

      await tester.pumpWidget(const SizedBox());

      expect(mock.last.isClosed, isTrue);
    });
  });
}
