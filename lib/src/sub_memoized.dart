import 'package:flutter_sub/flutter_sub.dart';

/// Caches the instance of a complex object.
///
/// [SubMemoized] will immediately call [create] on first call and store its result.
/// Inside of [builder], the previously created instance is provided. The provided value will stay persistent over rebuilds.
///
/// A rebuild of [SubMemoized] with different [keys] will call [create] again to create a new instance.
///
/// This Widget is just a wrapper around [SubValue] with less parameters to ease a transition from React Hooks.
/// See also:
/// - [SubValue] for more complex states
class SubMemoized<T> extends SubValue<T> {
  /// Caches the instance of a complex object.
  SubMemoized({
    required super.create,
    required super.builder,
    super.keys,
  });
}
