import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value_state.dart';
import 'package:flutter_sub/src/types.dart';

class SubValue<T> extends StatefulWidget {
  /// Creates, recreates, updates and disposes a Value T.
  ///
  /// [SubValue] calls [create] to create a value.
  /// The created value is provided to its child widgets through the [builder].
  ///
  /// Changing the return value of [keys] will trigger another call to [create].
  /// The updated value is then passed to [builder] and the widget is rebuilt.
  /// If no value is passed for [keys], the value is created once only and persist for the lifetime of this widget.
  ///
  /// The value can be updated by specifying the [update] parameter.
  /// This is useful if the created value is a controller, and its values rely on other variables up in the tree.
  ///
  /// To release any allocated resources, the value can be disposed with the [dispose] callback.
  /// [dispose] is called for every value that is discarded when [keys] change and once this widget is disposed entirely.
  ///
  /// The following example [SubValue] shows an example of creating a Stream for a search from our database.
  /// The stream is recreated when either the database or the search changes.
  /// The Stream can then be used in a StreamBuilder. The stream is appropriately kept in a State while we do not need an extra StatefulWidget.
  ///
  /// ```dart
  /// return SubValue(
  ///   create: () => database.findItems(search),
  ///   keys: [database, search],
  ///   builder: (context, stream) => StreamBuilder(
  ///     stream: stream,
  ///     builder: /* ... */,
  ///   ),
  /// );
  /// ```
  ///
  /// See also:
  /// - [SubValue.builder], which also passes [BuildContext].
  SubValue({
    required SubValueCreate<T> create,
    SubValueKeys? keys,
    SubValueUpdate<T>? update,
    SubValueDispose<T>? dispose,
    required this.builder,
  })  : create = ((context) => create()),
        keys = keys != null ? ((context) => keys) : null,
        update =
            update != null ? ((context, previous) => update(previous)) : null,
        dispose = dispose != null ? ((context, value) => dispose(value)) : null,
        super(key: null);

  /// Creates, recreates, updates and disposes a Value T.
  ///
  /// The same as SubValue, but also passes [BuildContext] for its operations.
  /// This is useful when creating [SubValue]s which depend on [InheritedWidget].
  ///
  /// See also:
  /// - [SubValue], which omits [BuildContext].
  const SubValue.builder({
    required this.create,
    this.keys,
    this.update,
    this.dispose,
    required this.builder,
  }) : super(key: null);

  /// Creates the value. Called at least once and everytime [keys] changes.
  final SubValueBuilderCreate<T> create;

  /// Updates the value. Called every build. If null, does nothing.
  /// In the call order, this comes after recreating the value.
  final SubValueBuilderUpdate<T>? update;

  /// Used to decide when to recreate the value. If null, the value is never recreated.
  final SubValueBuilderKeys? keys;

  /// Creates the child of this Widget with the value.
  final SubValueBuild<T> builder;

  /// Disposes the value. Called before recreation and when disposing. Useful for Listeners, etc.
  final SubValueBuilderDispose<T>? dispose;

  @override
  State<SubValue<T>> createState() => SubValueState<T>();
}
