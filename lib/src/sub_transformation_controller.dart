import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_listenable.dart';

class SubTransformationController
    extends SubDisposableListenable<TransformationController> {
  /// Creates and disposes a [TransformationController].
  ///
  /// See also:
  /// - [TransformationController]
  SubTransformationController({
    Matrix4? initialValue,
    required super.builder,
    super.keys,
  }) : super(
          create: () => TransformationController(initialValue),
        );
}
