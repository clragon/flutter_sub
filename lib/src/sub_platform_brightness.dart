import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_value.dart';
import 'package:flutter_sub/src/sub_value_listenable.dart';
import 'package:flutter_sub/src/sub_value_state.dart';
import 'package:flutter_sub/src/types.dart';

/// Returns the current platform [Brightness] value and rebuilds the widget when it changes.
///
/// See also:
/// - [Brightness]
class SubPlatformBrightness extends SubValueNotifier<Brightness> {
  /// Returns the current platform [Brightness] value and rebuilds the widget when it changes.
  SubPlatformBrightness({
    required SubValueBuild<Brightness> builder,
    ValueChanged<Brightness>? listener,
    bool initialize = false,
  }) : super(
          initialData: WidgetsBinding.instance.window.platformBrightness,
          builder: (context, notifier) => SubValueListener<Brightness>(
            listenable: notifier,
            listener: listener,
            initialize: initialize,
            builder: builder,
          ),
        );

  @override
  State<SubValue<ValueNotifier<Brightness>>> createState() =>
      _SubPlatformBrightness();
}

/// A [SubValueState] which mixes in [WidgetsBindingObserver] so that its [SubValue] can access [WidgetsBinding.window.platformBrightness].
class _SubPlatformBrightness extends SubValueState<ValueNotifier<Brightness>>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    value?.value = WidgetsBinding.instance.window.platformBrightness;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
