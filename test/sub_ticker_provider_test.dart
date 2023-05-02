import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubTickerProvider', () {
    testWidgets('correctly creates a TickerProvider', (tester) async {
      final mock = MockBuilder<TickerProvider>();
      await tester.pumpWidget(TickerMode(
        enabled: true,
        child: SubTickerProvider(
          builder: mock,
        ),
      ));

      final animationController = AnimationController(
          vsync: mock.single, duration: const Duration(seconds: 1))
        ..forward();

      final animationController2 = AnimationController(
          vsync: mock.single, duration: const Duration(seconds: 1))
        ..forward();

      animationController.dispose();
      animationController2.dispose();

      await tester.pumpWidget(const SizedBox());
    });
  });
}
