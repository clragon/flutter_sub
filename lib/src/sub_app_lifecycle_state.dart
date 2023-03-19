import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/sub_value_listenable.dart';
import 'package:flutter_sub/src/sub_value_state.dart';
import 'package:flutter_sub/src/sub_widgets_binding_observer.dart';
import 'package:flutter_sub/src/types.dart';

/// Returns the current [AppLifecycleState] value and rebuilds the widget when it changes.
///
/// See also:
/// - [AppLifecycleState]
class SubAppLifecycleState extends SubValueNotifier<AppLifecycleState?> {
  /// Returns the current [AppLifecycleState] value and rebuilds the widget when it changes.
  SubAppLifecycleState({
    required SubValueBuild<AppLifecycleState?> builder,
    super.listener,
    super.initialize,
  }) : super(
          initialData: WidgetsBinding.instance.lifecycleState,
          builder: (context, notifier) => builder(context, notifier.value),
        );

  @override
  State<SubValue<ValueNotifier<AppLifecycleState?>>> createState() =>
      _SubAppLifecycleStateState();
}

/// A [SubValueState] which mixes in [WidgetsBindingObserver] so that its [SubValue] can access [WidgetsBinding.instance.lifecycleState].
class _SubAppLifecycleStateState
    extends SubWidgetsBindingObserverState<ValueNotifier<AppLifecycleState?>> {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    value?.value = state;
  }
}
