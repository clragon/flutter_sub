import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

/// Subscribes to a [Listenable].
///
/// This Widget is similar to a [AnimatedBuilder].
/// Additionally, it allows attaching a callback that is called whenever the listenable notifies.
///
/// Example usage looks like this:
///
/// ```dart
/// return SubListener(
///   listanble: myChangeNotifier,
///   listener: () => print('notifier has fired!'),
///   builder: (context) => /* ... */,
/// );
/// ```
///
/// The listener is automatically attached and detached.
class SubListener extends SubValue<_SubListenerState> {
  /// Subscribes a callback to a [Listenable].
  ///
  /// - The optional [listener] is called when the listenable notifies.
  /// - If [initialize] is true, then [listener] is also called once this Widget is built for the first time.
  SubListener({
    required WidgetBuilder builder,
    required Listenable listenable,
    VoidCallback? listener,
    bool initialize = false,
  }) : super(
          create: () => _SubListenerState(
            listenable: listenable,
            listener: listener,
            initialize: initialize,
          ),
          update: (state) {
            if (state.listener != listener) {
              return _SubListenerState(
                listenable: listenable,
                listener: listener,
              );
            }
            return state;
          },
          keys: [listenable],
          dispose: (value) => value.dispose(),
          builder: (context, _) => builder(context),
        );
}

/// Holds the state for a [SubListener].
@immutable
class _SubListenerState {
  /// Holds the state for a [SubListener].
  _SubListenerState({
    required this.listenable,
    this.listener,
    this.initialize = false,
  }) {
    if (listener == null) return;
    if (initialize) {
      listener!.call();
    }
    listenable.addListener(listener!);
  }

  /// The listenable to which to attach [listener].
  final Listenable listenable;

  /// Called whenever [listenable] notifies.
  final VoidCallback? listener;

  /// Whether to call [listener] when the [SubListener] is created first.
  final bool initialize;

  /// Cleans up the state.
  void dispose() {
    if (listener == null) return;
    listenable.removeListener(listener!);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _SubListenerState &&
          initialize == other.initialize &&
          listenable == other.listenable &&
          listener == other.listener;

  // coverage:ignore-start
  @override
  int get hashCode => Object.hash(
        listenable,
        listener,
        initialize,
      );
  // coverage:ignore-end
}

/// A [SubValue] which holds a Value that is a descendant of [ChangeNotifier].
/// The dispose method is automatically handled.
abstract class SubDisposableListenable<T extends ChangeNotifier>
    extends SubValue<T> {
  /// Automatically disposes its ChangeNotifier.
  SubDisposableListenable({
    required super.create,
    super.keys,
    super.update,
    required super.builder,
  }) : super(
          dispose: (value) => value.dispose(),
        );

  /// Automatically disposes its ChangeNotifier.
  SubDisposableListenable.builder({
    required super.create,
    super.keys,
    super.update,
    required super.builder,
  }) : super.builder(
          dispose: (context, value) => value.dispose(),
        );
}
