import 'dart:ui';

import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubPlatformBrightness', () {
    testWidgets('calls its listener and builder', (tester) async {
      tester.binding.platformDispatcher.platformBrightnessTestValue =
          Brightness.light;
      final mock = MockBuilder<Brightness>();
      Brightness? out;

      await tester.pumpWidget(
        SubPlatformBrightness(
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, null);
      expect(mock.last, Brightness.light);

      tester.binding.platformDispatcher.platformBrightnessTestValue =
          Brightness.dark;

      await tester.pumpWidget(
        SubPlatformBrightness(
          listener: (value) => out = value,
          builder: mock,
        ),
      );

      expect(out, Brightness.dark);
      expect(mock.last, Brightness.dark);
    });
  });
}
