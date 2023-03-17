import 'package:flutter/material.dart';
import 'package:flutter_sub/developer.dart';
import 'package:flutter_sub/flutter_sub.dart';

/// Creates and disposes a [TabController].
///
/// See also:
/// - [TabController]
class SubTabController extends SubDisposableListenable<TabController>
    with SubSingleTickProviderMixin<TabController> {
  /// Creates and disposes a [TabController].
  SubTabController({
    required int initialLength,
    TickerProvider? vsync,
    int initialIndex = 0,
    SubValueKeys? keys,
    required super.builder,
  }) : super.builder(
          create: (context) => TabController(
            length: initialLength,
            initialIndex: initialIndex,
            vsync:
                vsync ?? (context as StatefulElement).state as TickerProvider,
          ),
          keys: keys != null ? (context) => keys : null,
        );
}
