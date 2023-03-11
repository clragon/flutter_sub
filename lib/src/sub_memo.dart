import 'package:flutter_sub/flutter_sub.dart';

class SubMemo<T> extends SubValue<T> {
  /// Caches the instance of a complex object.
  ///
  /// [SubMemo] will immediately call [create] on first call and store its result.
  /// Inside of [builder], the previously created instance is provided. The provided value will stay persistent over rebuilds.
  ///
  /// A rebuild of [SubMemo] with different [keys] will call [create] again to create a new instance.
  ///
  /// This Widget is just a wrapper around [SubValue] with less parameters to ease a transition from React Hooks.
  ///
  /// See also:
  ///
  /// - [SubValue] for more complex states
  SubMemo({
    required super.create,
    required super.builder,
    super.keys,
  });
}

class SubCallback<T extends Function> extends SubMemo<T> {
  /// Cache a function across rebuilds based on a list of keys.
  ///
  /// This is syntax sugar for [SubMemo], so that instead of:
  ///
  /// ```dart
  /// SubMemo(
  ///   create: () => () {
  ///     print('doSomething');
  ///   },
  ///   keys: [key],
  ///   builder: /* ... */,
  /// );
  /// ```
  ///
  /// we can directly do:
  ///
  /// ```dart
  /// SubMemo(
  ///   create: () {
  ///     print('doSomething');
  ///   },
  ///   keys: [key],
  ///   builder: /* ... */,
  /// );
  /// ```
  SubCallback({
    required T callback,
    required super.builder,
    super.keys,
  }) : super(create: () => callback);
}
