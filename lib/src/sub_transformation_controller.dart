import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_listenable.dart';

/// Creates and disposes a [TransformationController].
///
/// See also:
/// - [TransformationController]
class SubTransformationController
    extends SubDisposableListenable<TransformationController> {
  /// Creates and disposes a [TransformationController].
  SubTransformationController({
    Matrix4? initialValue,
    required super.builder,
    super.keys,
  }) : super(
          create: () => TransformationController(initialValue),
        );
}
