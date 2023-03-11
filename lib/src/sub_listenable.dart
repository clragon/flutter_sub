import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

class SubListener extends StatelessWidget {
  /// Subscribes a callback to a [Listenable].
  ///
  /// - The optional [listener] is called when the listenable notifies.
  /// - If [initialize] is true, then [listener] is also called once this Widget is built for the first time.
  const SubListener({
    required this.builder,
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

  /// Builds the widget below this one.
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return SubValue<_SubListenerState>(
      create: () => _SubListenerState(
        listenable: listenable,
        listener: listener,
        initialize: initialize,
      ),
      keys: [listenable, listener, initialize],
      dispose: (value) => value.dispose(),
      builder: (context, _) => builder(context),
    );
  }
}

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
