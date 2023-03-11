import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/sub_value_state.dart';

class SubSingleTickProvider extends SubValue<TickerProvider>
    with SubSingleTickProviderMixin<TickerProvider> {
  /// Creates a single usage [TickerProvider].
  ///
  /// See also:
  /// - [SubSingleTickProviderMixin]
  SubSingleTickProvider({
    required super.builder,
  }) : super.builder(
          create: (context) =>
              (context as StatefulElement).state as TickerProvider,
        );
}

/// A mixin that ensures that the State of a SubValue has a [TickerProvider].
///
/// See also:
/// - [SubSingleTickProvider] which uses this to provide a [TickerProvider].
/// - [SingleTickerProviderStateMixin]
mixin SubSingleTickProviderMixin<T> on SubValue<T> {
  @override
  State<SubValue<T>> createState() => _SubSingleTickProviderState<T>();
}

class _SubSingleTickProviderState<T> extends SubValueState<T>
    with SingleTickerProviderStateMixin {}
