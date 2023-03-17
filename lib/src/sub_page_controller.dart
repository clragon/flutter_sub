import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_listenable.dart';

/// Creates and disposes a [PageController].
///
/// See also:
/// - [PageController]
class SubPageController extends SubDisposableListenable<PageController> {
  /// Creates and disposes a [PageController].
  SubPageController({
    int initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    super.keys,
    required super.builder,
  }) : super(
          create: () => PageController(
            initialPage: initialPage,
            keepPage: keepPage,
            viewportFraction: viewportFraction,
          ),
        );
}
