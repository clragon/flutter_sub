import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubSingleTickProvider', () {
    testWidgets('correctly creates a single use TickerProvider',
        (tester) async {
      final mock = MockBuilder<TickerProvider>();
      await tester.pumpWidget(TickerMode(
        enabled: true,
        child: SubSingleTickProvider(
          builder: mock,
        ),
      ));

      final animationController = AnimationController(
          vsync: mock.single, duration: const Duration(seconds: 1))
        ..forward();

      expect(() => AnimationController(vsync: mock.single), throwsFlutterError);

      animationController.dispose();

      await tester.pumpWidget(const SizedBox());
    });
  });
}
