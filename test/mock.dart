import 'package:flutter/material.dart';
import 'package:flutter_sub/src/types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBuilder<T> extends Mock {
  MockBuilder({this.builder});

  final SubValueBuild? builder;

  List<T> args = [];
  Set<T> get uargs => args.toSet();

  T get single {
    assert(uargs.length == 1, 'unique args was length > 1');
    return uargs.last;
  }

  T get first => args.first;
  T get last => args.last;

  Widget call(
    BuildContext context,
    T value,
  ) {
    args.add(value);
    return builder?.call(context, value) ?? const SizedBox();
  }
}

class DisposableMock extends Mock {
  bool disposed = false;

  void dispose() {
    assert(!disposed, 'cannot dispose twice!');
    disposed = true;
  }
}

class MockValue extends Mock {
  @override
  String toString() => identityHashCode(this).toString();
}

Future<void> checkDisposal<T extends ChangeNotifier>(
    WidgetTester tester, Widget Function(MockBuilder<T> mock) builder) async {
  final mock = MockBuilder<T>();

  await tester.pumpWidget(builder(mock));

  mock.last.addListener(() {});

  await tester.pumpWidget(const SizedBox());

  expect(() => mock.last.addListener(() {}), throwsFlutterError);
}
