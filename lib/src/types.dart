import 'package:flutter/widgets.dart';

typedef SubValueCreate<T> = T Function();

typedef SubValueBuilderCreate<T> = T Function(BuildContext context);

typedef SubValueUpdate<T> = T Function(T previous);

typedef SubValueBuilderUpdate<T> = T Function(BuildContext context, T previous);

typedef SubValueBuild<T> = Widget Function(BuildContext context, T value);

typedef SubValueKeys = List<Object?>;

typedef SubValueBuilderKeys = List<Object?> Function(BuildContext context);

typedef SubValueDispose<T> = void Function(T value);

typedef SubValueBuilderDispose<T> = void Function(
    BuildContext context, T value);
