import 'package:flutter/widgets.dart';
import 'package:flutter_sub/developer.dart';

/// Creates an initial [AsyncSnapshot] as seen in a [FutureBuilder].
AsyncSnapshot<T> _createInitialSnapshot<T>(T? initialData) {
  if (initialData == null) {
    return AsyncSnapshot<T>.nothing();
  } else {
    return AsyncSnapshot<T>.withData(ConnectionState.none, initialData);
  }
}

/// Handles a [AsyncSnapshot] from a [FutureBuilder] and removes previous snapshot values when desired.
///
/// * [preserveState] determines if the current value should be preserved when the
/// [AsyncSnapshot] is changed.
///
/// See also:
/// - [SubFuture], uses this internally to handle the [AsyncSnapshot] of a [Future].
/// - [SubStream], uses this internally to handle the [AsyncSnapshot] of a [Stream].
SubValueBuild<AsyncSnapshot<T>> preservedSnapshotBuilder<T>({
  T? initialData,
  bool preserveState = true,
  required SubValueBuild<AsyncSnapshot<T>> builder,
}) {
  return (context, snapshot) {
    if (!preserveState &&
        [ConnectionState.none, ConnectionState.waiting]
            .contains(snapshot.connectionState)) {
      snapshot =
          _createInitialSnapshot(initialData).inState(snapshot.connectionState);
    }
    return builder(context, snapshot);
  };
}
