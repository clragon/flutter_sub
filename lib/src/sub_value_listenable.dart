import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_listenable.dart';
import 'package:flutter_sub/src/sub_state.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/types.dart';

/// Subscribes to a [ValueListenable] and returns its value.
///
/// This Widget is similar to a [ValueListenableBuilder].
/// Additionally, it allows attaching a callback that is called whenever the listenable notifies.
///
/// Example usage looks like this:
///
/// ```dart
/// return SubValueListener(
///   listanble: myValueNotifier,
///   listener: (value) => print('value is now $value'),
///   builder: (context, value) => /* ... */,
/// );
/// ```
///
/// The listener is automatically attached and detached.
///
/// See also:
/// - [ValueListenable], the created object
/// - [SubListener], the base class
class SubValueListener<T> extends SubListener {
  /// Subscribes to a [ValueListenable] and returns its value.
  ///
  /// - The optional [listener] is called when the listenable notifies.
  /// - If initialize is true, then [listener] is also called once this Widget is built for the first time.
  SubValueListener({
    required ValueListenable<T> listenable,
    required SubValueBuild<T> builder,
    ValueChanged<T>? listener,
    super.initialize,
  }) : super(
          listenable: listenable,
          listener: listener != null ? () => listener(listenable.value) : null,
          child: ValueListenableBuilder<T>(
            valueListenable: listenable,
            builder: (context, value, child) => builder(context, value),
          ),
        );
}

/// Creates and subscribes to a [ValueNotifier], then exposes its current state.
/// The notifier is automatically disposed.
///
/// This is a combination of a [SubValue] and a [ValueListenableBuilder].
/// Additionally, it allows attaching a callback that is called whenever the [ValueNotifier] notifies.
///
/// Example usage looks like this:
///
/// ```dart
/// return SubValueNotifier(
///   initialData: 0,
///   listener: (value) => print('value is now $value'),
///   builder: (context, notifier) => /* ... */,
/// );
/// ```
///
/// The listener is automatically attached and detached.
///
/// See also:
/// - [ValueNotifier]
/// - [SubValueListener]
/// - [SubState]
class SubValueNotifier<T> extends SubDisposableListenable<ValueNotifier<T>> {
  /// Creates and subscribes to a [ValueNotifier], then exposes its current state.
  /// The notifier is automatically disposed.
  ///
  /// - The optional [listener] is called when the listenable notifies.
  /// - If [initialize] is true, then [listener] is also called once this Widget is built for the first time.
  SubValueNotifier({
    required T initialData,
    required SubValueBuild<ValueNotifier<T>> builder,
    ValueChanged<T>? listener,
    bool initialize = false,
    super.keys,
  }) : super(
          create: () => ValueNotifier<T>(initialData),
          builder: (context, notifier) => SubValueListener<T>(
            listenable: notifier,
            listener: listener,
            initialize: initialize,
            builder: (context, value) => builder(context, notifier),
          ),
        );
}
