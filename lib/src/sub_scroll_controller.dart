import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_listenable.dart';

/// Creates and disposes a [ScrollController].
///
/// See also:
/// - [ScrollController]
class SubScrollController extends SubDisposableListenable<ScrollController> {
  /// Creates and disposes a [ScrollController].
  SubScrollController({
    double initialScrollOffset = 0.0,
    bool keepScrollOffset = true,
    String? debugLabel,
    required super.builder,
    super.keys,
  }) : super(
          create: () => ScrollController(
            initialScrollOffset: initialScrollOffset,
            keepScrollOffset: keepScrollOffset,
            debugLabel: debugLabel,
          ),
        );
}
