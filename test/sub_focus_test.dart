import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';

import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubFocusNode', () {
    testWidgets('is created and updated correctly', (tester) async {
      final mock = MockBuilder<FocusNode>();

      await tester.pumpWidget(
        SubFocusNode(
          builder: mock,
        ),
      );

      final node = FocusNode();

      expect(mock.last.debugLabel, node.debugLabel);
      expect(mock.last.onKey, node.onKey);
      expect(mock.last.onKeyEvent, node.onKeyEvent);
      expect(mock.last.skipTraversal, node.skipTraversal);
      expect(mock.last.canRequestFocus, node.canRequestFocus);
      expect(mock.last.descendantsAreFocusable, node.descendantsAreFocusable);

      String? debugLabel = 'abc';
      KeyEventResult onKey(node, event) => KeyEventResult.ignored;
      KeyEventResult onKeyEvent(node, event) => KeyEventResult.ignored;
      bool skipTraversal = true;
      bool canRequestFocus = false;
      bool descendantsAreFocusable = false;

      await tester.pumpWidget(
        SubFocusNode(
          debugLabel: debugLabel,
          onKey: onKey,
          onKeyEvent: onKeyEvent,
          skipTraversal: skipTraversal,
          canRequestFocus: canRequestFocus,
          descendantsAreFocusable: descendantsAreFocusable,
          builder: mock,
        ),
      );

      expect(mock.last.debugLabel, debugLabel);
      expect(mock.last.onKey, onKey);
      expect(mock.last.onKeyEvent, onKeyEvent);
      expect(mock.last.skipTraversal, skipTraversal);
      expect(mock.last.canRequestFocus, canRequestFocus);
      expect(mock.last.descendantsAreFocusable, descendantsAreFocusable);
    });

    testWidgets(
      'is disposed correctly',
      (tester) async => checkDisposal(
        tester,
        (mock) => SubFocusNode(
          builder: mock,
        ),
      ),
    );
  });

  group('SubFocusScopeNode', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<FocusScopeNode>();

      String? debugLabel = 'abc';
      KeyEventResult onKey(node, event) => KeyEventResult.ignored;
      KeyEventResult onKeyEvent(node, event) => KeyEventResult.ignored;
      bool skipTraversal = true;
      bool canRequestFocus = false;

      await tester.pumpWidget(
        SubFocusScopeNode(
          debugLabel: debugLabel,
          onKey: onKey,
          onKeyEvent: onKeyEvent,
          skipTraversal: skipTraversal,
          canRequestFocus: canRequestFocus,
          builder: mock,
        ),
      );

      expect(mock.last.debugLabel, debugLabel);
      expect(mock.last.onKey, onKey);
      expect(mock.last.onKeyEvent, onKeyEvent);
      expect(mock.last.skipTraversal, skipTraversal);
      expect(mock.last.canRequestFocus, canRequestFocus);
    });

    testWidgets(
      'is disposed correctly',
      (tester) async => checkDisposal(
        tester,
        (mock) => SubFocusScopeNode(
          builder: mock,
        ),
      ),
    );
  });
}
