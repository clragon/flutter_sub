import 'package:flutter_sub/developer.dart';
import 'package:flutter_sub/flutter_sub.dart';

/// Creates a default value if the value passed in is null.
///
/// The create function is only ever called if null is passed for value.
/// The dispose function is only called with values which have been created
/// with the create function.
///
/// If a default value is created and a non-null value is passed later, the default value will be disposed.
///
/// The following example shows basic usage.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return SubDefault(
///     // Our value, which may be null.
///     value: maybeNullValue,
///     create: () => someDefaultValue,
///     // Will only dispose the default value.
///     dispose: (value) => value.dispose(),
///     // Will always receive a value.
///     builder: (context, value) => /* ... */,
///   );
/// }
/// ```
class SubDefault<T> extends SubValue<_MaybeDefaultValue<T>> {
  /// Creates a default value if the value passed in is null.
  SubDefault({
    required T? value,
    required SubValueCreate<T> create,
    SubValueKeys? keys,
    SubValueDispose<T>? dispose,
    required SubValueBuild<T> builder,
  }) : super(
          create: () {
            if (value != null) {
              return _MaybeDefaultValue(value);
            } else {
              return _MaybeDefaultValue.asDefault(create());
            }
          },
          keys: [value, ...?keys],
          dispose: (value) {
            if (value.isDefault) {
              dispose?.call(value.value);
            }
          },
          builder: (context, value) => builder(context, value.value),
        );
}

/// Stores the value of a [SubDefault].
///
/// This is required so we only dispose the default value,
/// and not any value that is passed in, since we do not own those.
class _MaybeDefaultValue<T> {
  /// Stores the value of a [SubDefault].
  /// Use this to store values which are passed in from a parent.
  _MaybeDefaultValue(this.value) : isDefault = false;

  /// Stores the value of a [SubDefault].
  /// Use this to store values which are created as default.
  _MaybeDefaultValue.asDefault(this.value) : isDefault = true;

  /// The value.
  final T value;

  /// Whether this value is a default value.
  final bool isDefault;
}
