import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

/// Subscribes to a [Listenable].
///
/// This Widget is similar to a [AnimatedBuilder].
/// Additionally, it allows attaching a callback that is called whenever the [listenable] notifies.
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
class SubListener extends StatelessWidget {
  /// Subscribes a callback to a [Listenable].
  ///
  /// - The optional [listener] is called when the listenable notifies.
  /// - If [initialize] is true, then [listener] is also called once this Widget is built for the first time.
  const SubListener({
    @required this.child,
    @Deprecated('Use the child Parameter instead') this.builder,
    required this.listenable,
    this.listener,
    this.initialize = false,
  });

  /// The listenable to which to attach [listener].
  final Listenable listenable;

  /// Called whenever [listenable] notifies.
  final VoidCallback? listener;

  /// Whether to call [listener] when the [SubListener] is created initially.
  final bool initialize;

  /// The widget below this one.
  final Widget? child;

  /// Builds the widget below this one.
  @Deprecated('Use the child Parameter instead')
  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    assert(
      // ignore: deprecated_member_use_from_same_package
      builder != null || child != null,
      '$runtimeType must have a child widget!',
    );
    return SubValue<_SubListenerState>(
      create: () => _SubListenerState(
        listenable: listenable,
        listener: listener,
        initialize: initialize,
      ),
      keys: [listenable],
      dispose: (value) => value.dispose(),
      // ignore: deprecated_member_use_from_same_package
      builder: (context, _) => builder?.call(context) ?? child!,
    );
  }
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

  void dispose() {
    if (listener == null) return;
    listenable.removeListener(listener!);
  }
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
