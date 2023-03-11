import 'package:flutter/widgets.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';

void main() {
  group('SubTransformationController', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<TransformationController>();
      Matrix4 matrix = Matrix4.identity();

      await tester.pumpWidget(
        SubTransformationController(
          initialValue: matrix,
          builder: mock,
        ),
      );

      expect(mock.last.value, matrix);
    });
  });
}
