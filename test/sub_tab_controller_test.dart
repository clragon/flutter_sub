import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sub/flutter_sub.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock.dart';

void main() {
  group('SubTabController', () {
    testWidgets('is created correctly', (tester) async {
      final mock = MockBuilder<TabController>();
      const index = 1;
      const length = 4;

      await tester.pumpWidget(
        SubTabController(
          initialIndex: index,
          initialLength: length,
          builder: mock,
        ),
      );

      expect(mock.last.length, length);
      expect(mock.last.index, index);
    });

    testWidgets('initial values matches with real constructor', (tester) async {
      final mock = MockBuilder<TabController>();
      late TabController controller;

      await tester.pumpWidget(
        SubTabController(
          initialLength: 4,
          builder: mock,
        ),
      );
      await tester.pumpWidget(
        SubSingleTickProvider(builder: (_, value) {
          controller = TabController(length: 4, vsync: value);
          return Container();
        }),
      );

      expect(mock.single.index, controller.index);
    });

    testWidgets('allows passing custom vsync', (tester) async {
      final mock = MockBuilder<TabController>();
      final vsync = TickerProviderMock();
      final ticker = Ticker((_) {});
      when(vsync.createTicker((_) {})).thenReturn(ticker);

      await tester.pumpWidget(
        SubTabController(
          initialLength: 1,
          vsync: vsync,
          builder: mock,
        ),
      );

      verify(vsync.createTicker((_) {})).called(1);
      verifyNoMoreInteractions(vsync);

      await tester.pumpWidget(
        SubTabController(
          initialLength: 1,
          vsync: vsync,
          builder: mock,
        ),
      );

      verifyNoMoreInteractions(vsync);
      ticker.dispose();
    });

    testWidgets(
      'is disposed correctly',
      (tester) async => checkDisposal(
        tester,
        (mock) => SubTabController(
          initialLength: 4,
          builder: mock,
        ),
      ),
    );
  });
}

class TickerProviderMock extends Mock implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => super.noSuchMethod(
        Invocation.getter(#createTicker),
        returnValue: Ticker(onTick),
      ) as Ticker;
}
