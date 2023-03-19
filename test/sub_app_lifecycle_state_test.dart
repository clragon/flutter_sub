import 'dart:ui';

import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubAppLifecycleState', () {
    testWidgets('calls its listener and builder', (tester) async {
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      final mock = MockBuilder<AppLifecycleState?>();
      AppLifecycleState? out;

      await tester.pumpWidget(
        SubAppLifecycleState(
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, null);
      expect(mock.last, AppLifecycleState.resumed);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);

      await tester.pumpWidget(
        SubAppLifecycleState(
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, AppLifecycleState.inactive);
      expect(mock.last, AppLifecycleState.inactive);
    });
  });
}
