import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubPageController', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<PageController>(
        builder: (context, value) => PageView(controller: value),
      );
      int initialPage = 2;
      bool keepPage = false;
      double viewportFraction = 0.8;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SubPageController(
            initialPage: initialPage,
            keepPage: keepPage,
            viewportFraction: viewportFraction,
            builder: mock,
          ),
        ),
      );

      expect(mock.last.initialPage, initialPage);
      expect(mock.last.keepPage, keepPage);
      expect(mock.last.viewportFraction, viewportFraction);
    });

    testWidgets(
      'is disposed correctly',
      (tester) async => checkDisposal(
        tester,
        (mock) => SubPageController(
          builder: mock,
        ),
      ),
    );
  });
}
