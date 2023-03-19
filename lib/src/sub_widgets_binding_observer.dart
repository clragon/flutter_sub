import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/sub_value_state.dart';

/// A [SubValueState] which mixes in [WidgetsBindingObserver] so that its [SubValue] can subscribe to it.
class SubWidgetsBindingObserverState<T> extends SubValueState<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
