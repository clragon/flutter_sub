import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_sub/src/snapshot.dart';
import 'package:flutter_sub/src/types.dart';

/// Creates and subscribes to a [Stream], then exposes its current state as an [AsyncSnapshot].
///
/// See also:
/// - [Stream], the object listened.
/// - [SubFuture], similar to [SubStream] but for [Future].
class SubStream<T> extends SubValue<Stream<T>> {
  /// Creates and subscribes to a [Stream], then exposes its current state as an [AsyncSnapshot].
  ///
  /// * [listener] is called with every event the stream emits.
  /// * [preserveState] determines if the current value should be preserved when changing
  /// the [Stream] instance.
  ///
  /// When [preserveState] is true (the default) update jank is reduced when switching
  /// streams, but this may result in inconsistent state when using multiple
  /// or nested streams.
  SubStream({
    required super.create,
    super.keys,
    super.update,
    T? initialData,
    bool preserveState = true,
    ValueChanged<T>? listener,
    required SubValueBuild<AsyncSnapshot<T>> builder,
  }) : super(
          builder: (context, stream) => SubValue<Stream<T>>(
            create: () => stream.asBroadcastStream(
              onCancel: (subscription) => subscription.cancel(),
            ),
            keys: [stream],
            builder: (context, stream) => SubSubscriber<T>(
              stream: stream,
              listener: listener,
              child: StreamBuilder<T>(
                initialData: initialData,
                stream: stream,
                builder: preservedSnapshotBuilder(
                  preserveState: preserveState,
                  initialData: initialData,
                  builder: builder,
                ),
              ),
            ),
          ),
        );
}

/// Creates and disposes a [StreamController].
///
/// See also:
/// - [StreamController], the created object
/// - [SubStream], to listen to the created [StreamController]
class SubStreamController<T> extends SubValue<StreamController<T>> {
  /// Creates and disposes a [StreamController].
  SubStreamController({
    bool sync = false,
    VoidCallback? onListen,
    VoidCallback? onCancel,
    required super.builder,
    super.keys,
  }) : super(
          create: () => StreamController<T>.broadcast(
            sync: sync,
            onCancel: onCancel,
            onListen: onListen,
          ),
          dispose: (value) => value.close(),
        );
}
