import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubState', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<ValueNotifier<String>>();
      String text = 'abc';

      await tester.pumpWidget(
        SubState(
          initialData: text,
          builder: mock,
        ),
      );

      expect(mock.last.value, text);
    });

    testWidgets(
      'is disposed correctly',
      (tester) async => checkDisposal(
        tester,
        (mock) => SubState(
          initialData: 'abc',
          builder: mock,
        ),
      ),
    );
  });
}
