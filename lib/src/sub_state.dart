import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_stream.dart';
import 'package:flutter_sub/src/sub_value_listenable.dart';

/// Creates a variable and subscribes to it.
///
/// Whenever [ValueNotifier.value] updates, it will rebuild the [builder].
/// On the first call, it initializes [ValueNotifier] to initialData. initialData is ignored
/// on subsequent calls.
///
/// The following example showcases a basic counter application:
///
/// ```dart
/// class Counter extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return SubState(
///       initialData: 0,
///       builder: (context, counter) => GestureDetector(
///         // automatically triggers a rebuild of the Counter widget
///         onTap: () => counter.value++,
///         child: Text(counter.value.toString()),
///       ),
///     );
///   }
/// }
/// ```
///
/// This is a Wrapper around [SubValueNotifier] with less parameters to ease a transition from React Hooks.
///
/// See also:
/// - [ValueNotifier]
/// - [SubStreamController], an alternative to [ValueNotifier] for state.
class SubState<T> extends SubValueNotifier<T> {
  /// Creates a variable and subscribes to it.
  ///
  /// Whenever [ValueNotifier.value] updates, it will rebuild the [builder].
  /// On the first call, it initializes [ValueNotifier] to initialData. initialData is ignored
  /// on subsequent calls.
  SubState({
    required super.initialData,
    required super.builder,
    super.keys,
  });
}
