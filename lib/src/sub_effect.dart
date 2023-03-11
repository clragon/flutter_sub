import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_sub/src/types.dart';

class SubEffect extends SubValue<VoidCallback?> {
  /// Useful for side-effects and optionally canceling them.
  ///
  /// [SubEffect] calls its effect synchronously on every `build`, unless
  /// [keys] is specified. In which case the effect is called again only if
  /// any value inside [keys] as changed.
  ///
  /// It takes an [effect] callback and calls it synchronously.
  /// That [effect] may optionally return a function, which will be called when the [effect] is called again or if the widget is disposed.
  ///
  /// By default [effect] is called on every `build` call, unless [keys] is specified.
  /// In which case, [effect] is called once on the first build and whenever something within [keys] changes.
  ///
  /// The following example uses [SubEffect] to subscribes to a [Stream] and cancels the subscription when the widget is disposed.
  /// If the [Stream] changes, it will cancel the listening on the previous [Stream] and listen to the new one.
  ///
  /// ```dart
  /// Stream stream;
  ///
  /// Widget build(BuildContext context) {
  ///   return SubEffect(
  ///    effect: () {
  ///      final subscription = stream.listen(print);
  ///      // This will cancel the subscription when the widget is disposed
  ///       // or if the callback is called again.
  ///      return subscription.cancel;
  ///     },
  ///     // when the stream changes, useEffect will call the callback again.
  ///    keys: [stream],
  ///    child: /* ... */,
  ///   );
  /// }
  /// ```
  SubEffect({
    required VoidCallback? Function() effect,
    required Widget child,
    SubValueKeys? keys,
  }) : super(
          create: () => effect(),
          builder: (context, value) => child,
          dispose: (value) => value?.call(),
          keys: keys ?? [UniqueKey()],
        );
}
