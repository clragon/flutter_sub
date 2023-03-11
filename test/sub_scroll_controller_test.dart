import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubScrollController', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<ScrollController>(
        builder: (context, value) => ListView(controller: value),
      );
      const offset = 1.0;
      const keepOffset = false;
      const debugLabel = 'e';

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SubScrollController(
            initialScrollOffset: offset,
            keepScrollOffset: keepOffset,
            debugLabel: debugLabel,
            builder: mock,
          ),
        ),
      );

      expect(mock.last.offset, offset);
      expect(mock.last.keepScrollOffset, keepOffset);
      expect(mock.last.debugLabel, debugLabel);
    });

    testWidgets(
      'is disposed correctly',
      (tester) async => checkDisposal(
        tester,
        (mock) => SubScrollController(
          builder: mock,
        ),
      ),
    );
  });
}
