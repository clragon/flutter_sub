import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubAnimator', () {
    testWidgets('calls its listener and builder', (tester) async {
      final mock = MockBuilder<double>();
      final animation = AnimationController(vsync: const TestVSync());
      double? out;

      await tester.pumpWidget(
        SubAnimator<double>(
          animation: animation,
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, null);
      expect(mock.last, 0);

      animation.animateTo(1, duration: Duration.zero);
      await tester.pumpWidget(
        SubAnimator<double>(
          animation: animation,
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, 1);
      expect(mock.last, 1);
    });
  });

  group('SubAnimationController', () {
    testWidgets('is created and updated correctly', (tester) async {
      final mock = MockBuilder<AnimationController>();

      await tester.pumpWidget(
        SubAnimationController(builder: mock),
      );

      final animationController = AnimationController(vsync: const TestVSync());

      expect(mock.last.value, animationController.value);
      expect(mock.last.duration, animationController.duration);
      expect(mock.last.reverseDuration, animationController.reverseDuration);
      expect(mock.last.debugLabel, animationController.debugLabel);
      expect(mock.last.lowerBound, animationController.lowerBound);
      expect(mock.last.upperBound, animationController.upperBound);
      expect(
          mock.last.animationBehavior, animationController.animationBehavior);

      await tester.pumpWidget(const SizedBox());

      Duration? duration = Duration.zero;
      Duration? reverseDuration = Duration.zero;
      String? debugLabel = 'abc';
      double initialValue = 0.5;
      double lowerBound = 0;
      double upperBound = 2;
      AnimationBehavior animationBehavior = AnimationBehavior.preserve;

      await tester.pumpWidget(
        SubAnimationController(
          initialValue: initialValue,
          duration: duration,
          reverseDuration: reverseDuration,
          debugLabel: debugLabel,
          lowerBound: lowerBound,
          upperBound: upperBound,
          animationBehavior: animationBehavior,
          builder: mock,
          keys: const [],
        ),
      );

      expect(mock.last.value, initialValue);
      expect(mock.last.duration, duration);
      expect(mock.last.reverseDuration, reverseDuration);
      expect(mock.last.debugLabel, debugLabel);
      expect(mock.last.lowerBound, lowerBound);
      expect(mock.last.upperBound, upperBound);
      expect(mock.last.animationBehavior, animationBehavior);

      const newDuration = Duration(milliseconds: 500);
      const newReverseDuration = Duration(milliseconds: 500);

      await tester.pumpWidget(
        SubAnimationController(
          duration: newDuration,
          reverseDuration: newReverseDuration,
          builder: mock,
        ),
      );

      expect(mock.last.duration, newDuration);
      expect(mock.last.reverseDuration, newReverseDuration);
    });

    testWidgets('is disposed correctly', (tester) async {
      final mock = MockBuilder<AnimationController>();

      await tester.pumpWidget(
        SubAnimationController(builder: mock),
      );

      await tester.pumpWidget(const SizedBox());

      expect(() => mock.last.dispose(), throwsFlutterError);
    });
  });
}
