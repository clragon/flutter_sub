[![pub package](https://img.shields.io/pub/v/flutter_sub.svg)](https://pub.dartlang.org/packages/flutter_sub)
[![Build Status](https://github.com/clragon/flutter_sub/actions/workflows/test.yml/badge.svg)](https://github.com/clragon/flutter_sub/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/clragon/flutter_sub/badge.svg)](https://coveralls.io/github/clragon/flutter_sub)

# Flutter Sub

Provides managing State which depends on other State in the Widget tree
as well as reusable state (similar to hooks) for Flutter.

A Sub is a compact version of a StatefulWidget that creates, updates and disposes a Value.

## Motivation

Because almost all State in Flutter is bound to the tree, it is reasonable
to come accross the requirement of creating State which depends on other State.

As an example, a Widget which displays results from a database stream:

```dart
class Example extends StatefulWidget {
  const Example({
    super.key,
    required this.search,
    required this.database,
  });

  final String search;
  final Database dabatase;

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late Stream<String> results;

  @override
  void initState() {
    super.initState();
    results = widget.database.search(widget.search);
  }

  @override
  void didUpdateWidget(Example oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.search != oldWidget.search
        || widget.database != oldWidget.database) {
      results = widget.database.search(widget.search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: results,
      builder: /* ... */,
    );
  }
}
```

If the search or database parameters change, the UI should reflect this,
therefore we implement `didUpdateWidget`.

Writing methods like `didUpdateWidget` can be very tedious and repetetive.

The Sub Widgets simplify this process:

```dart
class Example extends StatelessWidget {
  const Example({
    super.key,
    required this.search,
    required this.database,
  });

  final String search;
  final Database dabatase;

  @override
  Widget build(BuildContext context) {
    return SubStream<String>(
      create: () => database.search(widget.search),
      keys: [database, search],
      builder: /* ... */,
    );
  }
}
```

The `SubStream` Widget takes care of creation the stream
and automatically recreates it whenever one of our dependencies, listed in `keys` changes.
