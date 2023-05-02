import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

/// Subscribes to a [Stream].
///
/// Allows attaching a callback that is called whenever the stream emits.
/// Does not rebuild its child widget.
///
/// Example usage looks like this:
///
/// ```dart
/// return SubListener(
///   stream: myStream,
///   listener: (event) => print('$event has been emitted!'),
///   child: /* ... */,
/// );
/// ```
///
/// The subscription is automatically closed.
class SubSubscriber<T> extends SubValue<StreamSubscription<T>?> {
  /// Subscribes to a [Stream].
  ///
  /// - The optional [listener] is attached to the stream.
  SubSubscriber({
    required Widget child,
    required Stream<T> stream,
    ValueChanged<T>? listener,
  }) : super(
          create: () => listener != null ? stream.listen(listener) : null,
          keys: [stream],
          dispose: (value) => value?.cancel(),
          builder: (context, _) => child,
        );
}
