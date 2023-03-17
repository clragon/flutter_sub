import 'package:flutter/widgets.dart';
import 'package:flutter_sub/developer.dart';
import 'package:flutter_sub/flutter_sub.dart';

class SubAnimator<T> extends SubValueListener<T> {
  /// Subscribes to an [Animation] and returns its value.
  ///
  /// - The optional [listener] is called when the listenable notifies.
  /// - If [initialize] is true, then [listener] is also called once this Widget is built for the first time.
  ///
  /// See also:
  /// - [Animation]
  /// - [SubValueListener], [SubListener], [SubStream]
  SubAnimator({
    required Animation<T> animation,
    required super.builder,
    super.listener,
    super.initialize,
  }) : super(listenable: animation);
}

class SubAnimationController extends SubValue<AnimationController>
    with SubSingleTickProviderMixin<AnimationController> {
  /// Creates an [AnimationController] and automatically disposes it when necessary.
  ///
  /// If no [vsync] is provided, the [TickerProvider] is implicitly obtained using a [SubSingleTickProviderMixin].
  ///
  /// Changing the [duration] parameter automatically updates the [AnimationController.duration].
  ///
  /// [initialValue], [lowerBound], [upperBound] and [debugLabel] are ignored after the first call.
  ///
  /// See also:
  /// - [AnimationController], the created object.
  /// - [SubAnimator], to listen to the created [AnimationController].
  SubAnimationController({
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
    double initialValue = 0,
    double lowerBound = 0,
    double upperBound = 1,
    TickerProvider? vsync,
    AnimationBehavior animationBehavior = AnimationBehavior.normal,
    required super.builder,
    SubValueKeys? keys,
  }) : super.builder(
          create: (context) => AnimationController(
            value: initialValue,
            vsync:
                vsync ?? (context as StatefulElement).state as TickerProvider,
            duration: duration,
            reverseDuration: reverseDuration,
            debugLabel: debugLabel,
            lowerBound: lowerBound,
            upperBound: upperBound,
            animationBehavior: animationBehavior,
          ),
          update: (context, previous) {
            if (previous.duration != duration) {
              previous.duration = duration;
            }
            if (previous.reverseDuration != reverseDuration) {
              previous.reverseDuration = reverseDuration;
            }
            return previous;
          },
          keys: keys != null ? (context) => keys : null,
          dispose: (context, value) => value.dispose(),
        );
}
