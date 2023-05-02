import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/sub_value_state.dart';

/// Creates a [TickerProvider].
///
/// See also:
/// - [SubTickerProviderMixin]
class SubTickerProvider extends SubValue<TickerProvider>
    with SubTickerProviderMixin<TickerProvider> {
  /// Creates a [TickerProvider].
  SubTickerProvider({
    required super.builder,
  }) : super.builder(
          create: (context) =>
              (context as StatefulElement).state as TickerProvider,
        );
}

/// A mixin that ensures that the State of a SubValue has a [TickerProvider].
///
/// See also:
/// - [SubTickerProvider] which uses this to provide a [TickerProvider].
/// - [TickerProviderStateMixin]
mixin SubTickerProviderMixin<T> on SubValue<T> {
  @override
  State<SubValue<T>> createState() => _SubSingleTickProviderState<T>();
}

/// A [SubValueState] which mixes in [TickerProviderStateMixin] so that a [TickerProvider] can be used in its corresponding [SubValue].
class _SubSingleTickProviderState<T> extends SubValueState<T>
    with TickerProviderStateMixin {}
