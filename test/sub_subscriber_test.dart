import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SubSubscriber', () {
    testWidgets('adds listener to stream', (tester) async {
      Stream<int> stream = Stream.value(1);
      int? value;
      Widget builder(Stream<int> stream) => SubSubscriber<int>(
            stream: stream,
            listener: (event) => value = event,
            child: const SizedBox(),
          );

      await tester.pumpWidget(builder(stream));
      expect(value, 1);
    });

    testWidgets('adds no listener to stream', (tester) async {
      Stream<int> stream = Stream.value(1);
      Widget builder(Stream<int> stream) => SubSubscriber<int>(
            stream: stream,
            child: const SizedBox(),
          );

      await tester.pumpWidget(builder(stream));
      stream.listen((event) {});
    });
  });
}
