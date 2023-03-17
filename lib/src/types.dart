import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';

/// Called to create the value for a [SubValue].
typedef SubValueCreate<T> = T Function();

/// Called to create the value for a [SubValue] with [BuildContext].
typedef SubValueBuilderCreate<T> = T Function(BuildContext context);

/// Called to update the value for a [SubValue].
typedef SubValueUpdate<T> = T Function(T previous);

/// Called to update the value for a [SubValue] with [BuildContext].
typedef SubValueBuilderUpdate<T> = T Function(BuildContext context, T previous);

/// Called to build the child of a [SubValue] with the created Value.
typedef SubValueBuild<T> = Widget Function(BuildContext context, T value);

/// Called to check whether to recreate the value of a [SubValue].
typedef SubValueKeys = List<Object?>;

/// Called to check whether to recreate the value of a [SubValue] with [BuildContext].
typedef SubValueBuilderKeys = List<Object?> Function(BuildContext context);

/// Called to dispose the Value of a [SubValue].
typedef SubValueDispose<T> = void Function(T value);

/// Called to dispose the Value of a [SubValue] with [BuildContext].
typedef SubValueBuilderDispose<T> = void Function(
    BuildContext context, T value);
