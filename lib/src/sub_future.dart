import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_sub/src/future.dart';
import 'package:flutter_sub/src/types.dart';

class SubFuture<T> extends SubValue<Future<T>> {
  /// Creates and subscribes to a [Future], then exposes its current state as an [AsyncSnapshot].
  ///
  /// * [preserveState] determines if the current value should be preserved when changing
  /// the [Future] instance.
  ///
  /// See also:
  /// - [Future], the listened object.
  /// - [SubStream], similar to [SubFuture] but for [Stream].
  SubFuture({
    required super.create,
    super.keys,
    super.update,
    T? initialData,
    bool preserveState = true,
    required SubValueBuild<AsyncSnapshot<T>> builder,
  }) : super(
          builder: (context, future) => FutureBuilder<T>(
            initialData: initialData,
            future: future,
            builder: preservedSnapshotBuilder(
              preserveState: preserveState,
              initialData: initialData,
              builder: builder,
            ),
          ),
        );
}
