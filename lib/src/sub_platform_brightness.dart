import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/sub_value_listenable.dart';
import 'package:flutter_sub/src/sub_value_state.dart';
import 'package:flutter_sub/src/sub_widgets_binding_observer.dart';
import 'package:flutter_sub/src/types.dart';

/// Returns the current platform [Brightness] value and rebuilds the widget when it changes.
///
/// See also:
/// - [Brightness]
class SubPlatformBrightness extends SubValueNotifier<Brightness> {
  /// Returns the current platform [Brightness] value and rebuilds the widget when it changes.
  SubPlatformBrightness({
    required SubValueBuild<Brightness> builder,
    super.listener,
    super.initialize,
  }) : super(
          initialData:
              WidgetsBinding.instance.platformDispatcher.platformBrightness,
          builder: (context, notifier) => builder(context, notifier.value),
        );

  @override
  State<SubValue<ValueNotifier<Brightness>>> createState() =>
      _SubPlatformBrightnessState();
}

/// A [SubValueState] which mixes in [WidgetsBindingObserver] so that its [SubValue] can access [WidgetsBinding.window.platformBrightness].
class _SubPlatformBrightnessState
    extends SubWidgetsBindingObserverState<ValueNotifier<Brightness>> {
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    value?.value =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}
