import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

/// Creates and disposes a [FocusNode].
///
/// See also:
/// - [FocusNode]
class SubFocusNode extends SubDisposableListenable<FocusNode> {
  /// Creates and disposes a [FocusNode].
  SubFocusNode({
    String? debugLabel,
    FocusOnKeyCallback? onKey,
    FocusOnKeyEventCallback? onKeyEvent,
    bool skipTraversal = false,
    bool canRequestFocus = true,
    bool descendantsAreFocusable = true,
    required super.builder,
  }) : super(
          create: () => FocusNode(
            debugLabel: debugLabel,
            onKey: onKey,
            onKeyEvent: onKeyEvent,
            skipTraversal: skipTraversal,
            canRequestFocus: canRequestFocus,
            descendantsAreFocusable: descendantsAreFocusable,
          ),
          update: (previous) => previous
            ..debugLabel = debugLabel
            ..skipTraversal = skipTraversal
            ..canRequestFocus = canRequestFocus
            ..descendantsAreFocusable = descendantsAreFocusable
            ..onKey = onKey
            ..onKeyEvent = onKeyEvent,
        );
}

/// Creates and disposes a [FocusScopeNode].
///
/// See also:
/// - [FocusScopeNode]
class SubFocusScopeNode extends SubDisposableListenable<FocusScopeNode> {
  /// Creates and disposes a [FocusScopeNode].
  SubFocusScopeNode({
    String? debugLabel,
    FocusOnKeyCallback? onKey,
    FocusOnKeyEventCallback? onKeyEvent,
    bool skipTraversal = false,
    bool canRequestFocus = true,
    required super.builder,
  }) : super(
          create: () => FocusScopeNode(
            debugLabel: debugLabel,
            skipTraversal: skipTraversal,
            canRequestFocus: canRequestFocus,
            onKey: onKey,
            onKeyEvent: onKeyEvent,
          ),
          update: (previous) => previous
            ..debugLabel = debugLabel
            ..skipTraversal = skipTraversal
            ..canRequestFocus = canRequestFocus
            ..onKey = onKey
            ..onKeyEvent = onKeyEvent,
        );
}
