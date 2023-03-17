import 'package:flutter/material.dart';
import 'package:flutter_sub/flutter_sub.dart';

class SubTabController extends SubDisposableListenable<TabController>
    with SubSingleTickProviderMixin<TabController> {
  /// Creates and disposes a [TabController].
  ///
  /// See also:
  /// - [TabController]
  SubTabController({
    required int initialLength,
    TickerProvider? vsync,
    int initialIndex = 0,
    super.keys,
    required super.builder,
  }) : super.builder(
          create: (context) => TabController(
            length: initialLength,
            initialIndex: initialIndex,
            vsync:
                vsync ?? (context as StatefulElement).state as TickerProvider,
          ),
        );
}
