import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_listenable.dart';
import 'package:flutter_sub/src/sub_state.dart';
import 'package:flutter_sub/src/types.dart';

class SubValueListener<T> extends SubListener {
  /// Subscribes to a [ValueListenable] and returns its value.
  ///
  /// - The optional [listener] is called when the listenable notifies.
  /// - If [initialize] is true, then [listener] is also called once this Widget is built for the first time.
  ///
  /// See also:
  /// - [ValueListenable], the created object
  /// - [SubListener], the base class
  SubValueListener({
    required ValueListenable<T> listenable,
    required SubValueBuild<T> builder,
    ValueChanged<T>? listener,
    super.initialize,
  }) : super(
          listenable: listenable,
          listener: listener != null ? () => listener(listenable.value) : null,
          builder: (context) => ValueListenableBuilder<T>(
            valueListenable: listenable,
            builder: (context, value, child) => builder(context, value),
          ),
        );
}

class SubValueNotifier<T> extends SubDisposableListenable<ValueNotifier<T>> {
  /// Creates and subscribes to a [ValueNotifier], then exposes its current state.
  /// The notifier is automatically disposed.
  ///
  /// See also:
  /// - [ValueNotifier]
  /// - [SubValueListener]
  /// - [SubState]
  SubValueNotifier({
    required T initialData,
    required SubValueBuild<ValueNotifier<T>> builder,
    super.keys,
  }) : super(
          create: () => ValueNotifier<T>(initialData),
          builder: (context, notifier) => SubValueListener<T>(
            listenable: notifier,
            builder: (context, value) => builder(context, notifier),
          ),
        );
}
