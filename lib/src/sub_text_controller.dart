import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/sub_listenable.dart';

class SubTextEditingController
    extends SubDisposableListenable<TextEditingController> {
  /// Creates and disposes a [TextEditingController].
  ///
  /// The [text] parameter can be used to set the initial value of the
  /// controller.
  SubTextEditingController({
    String? text,
    super.keys,
    required super.builder,
  }) : super(
          create: () => TextEditingController(text: text),
        );

  /// Creates a [TextEditingController] from the initial [value] that will
  /// be disposed automatically.
  SubTextEditingController.fromValue({
    TextEditingValue? value,
    required super.builder,
    super.keys,
  }) : super(
          create: () => TextEditingController.fromValue(value),
        );
}
