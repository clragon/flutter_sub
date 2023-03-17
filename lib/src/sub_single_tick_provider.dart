import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/sub_value_state.dart';

/// Creates a single usage [TickerProvider].
///
/// See also:
/// - [SubSingleTickProviderMixin]
class SubSingleTickProvider extends SubValue<TickerProvider>
    with SubSingleTickProviderMixin<TickerProvider> {
  /// Creates a single usage [TickerProvider].
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

/// A [SubValueState] which mixes in [SingleTickerProviderStateMixin] so that a [TickerProvider] can be used in its corresponding [SubValue].
class _SubSingleTickProviderState<T> extends SubValueState<T>
    with SingleTickerProviderStateMixin {}
