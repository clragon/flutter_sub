import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubTextEditingController', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<TextEditingController>();
      String text = 'abc';

      await tester.pumpWidget(
        SubTextEditingController(
          text: text,
          builder: mock,
        ),
      );

      expect(mock.last.text, text);
    });

    testWidgets('is created correctly from value', (tester) async {
      final mock = MockBuilder<TextEditingController>();
      const value = TextEditingValue(text: 'abc');

      await tester.pumpWidget(
        SubTextEditingController.fromValue(
          value: value,
          builder: mock,
        ),
      );

      expect(mock.last.value, value);
    });

    testWidgets(
      'is disposed correctly',
      (tester) async => checkDisposal(
        tester,
        (mock) => SubTextEditingController(
          builder: mock,
        ),
      ),
    );
  });
}
