[![pub package](https://img.shields.io/pub/v/flutter_sub.svg)](https://pub.dartlang.org/packages/flutter_sub)
[![Build Status](https://github.com/clragon/flutter_sub/actions/workflows/test.yml/badge.svg)](https://github.com/clragon/flutter_sub/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/clragon/flutter_sub/badge.svg)](https://coveralls.io/github/clragon/flutter_sub)

# Flutter Sub

Provides managing State which depends on other State in the Widget tree
as well as reusable state (similar to hooks) for Flutter.

A Sub is a compact version of a StatefulWidget that creates, updates and disposes a Value.

### Overview

- [Flutter Sub](#flutter-sub)
  - [Motivation](#motivation)
  - [Principle](#principle)
  - [Hooks](#hooks)
- [Custom subs](#custom-subs)
  - [SubValue](#subvalue)
  - [Widgets in Builder](#widgets-in-builder)
  - [SubValue.builder](#subvaluebuilder)
  - [SubValueState](#subvaluestate)
- [Inbuilt Subs](#inbuilt-subs)
  - [Async Subs](#async-subs)
  - [Animation Subs](#animation-subs)
  - [Listenable Subs](#listenable-subs)
  - [Other Subs](#other-subs)
  - [Hook-alikes](#hook-alikes)

## Motivation

Because almost all State in Flutter is bound to the tree, it is reasonable
to come accross the requirement of creating State which depends on other State.

Here is how you create a stream from your database that is automatically recreated when the search changes in flutter_sub:

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
      builder: (context, result) => /* ... */,
    );
  }
}
```

Pretty simple, right?
If the search or database parameters change, our stream is recreated.

The `SubStream` Widget takes care of creation the stream
and automatically recreates it whenever one of our dependencies, listed in `keys` changes.

Here is the same code without flutter_sub:

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

In a normal StatefulWidget, we have to implement `didUpdateWidget` and check every value manually.
This can lead to very repetetive and long code. The Sub Widgets simplify this process.

## Principle

Sub Widgets are basically just a shortcut to creating a `StatefulWidget`.
A `State` is needed to hold the value and its keys.

To show the idea in pseudo-code:

```dart
var myValue;

@override
Widget build(BuildContext context) {

  if (oldKeys != newKeys) {
    // keys have changed, the value is recreated.
    dispose(myValue);
    myValue = create();
  }

  // the value is passed to the child widget.
  return build(myValue);
}
```

This code is simplified.
To see the full implementation, you can check out [SubValueState](./lib/src/sub_value_state.dart).

## Hooks

You might have notived that this library has certain similarities to [flutter_hooks](https://pub.dev/packages/flutter_hooks).  
The primary purpose of this library is to provide convenient interstate relationships, but while building it, we noticed that it also allows the creation of easy resuable `State` pieces.

As such, it can fill a similar role to hooks, while having some advantages:

- Subs retain a syntax that is close to Flutter  
  Unlike hooks, Subs are Widgets and look and feel exactly like any part of the Widget tree.

- Subs do not replace Stateful or Stateless widgets, but compliment them  
  To use Subs you do not need to replace your Widgets with Hook variants.
  Subs work indepedently and in combination with the usual Flutter widgets.
  They can even be combined with `StatefulWidgets` where the `State` variables are used as Keys of the Sub.

- Subs are not magic  
  As seen in the above Principle sections, the implementation behind Subs is extremely simple. They are just a shortcut to `StatefulWidget`. You dont have to learn something new or follow special rules. Its also very easy to make your own custom Subs.

The way Subs are built also comes with one "disadvantage":  
Because Subs are Widgets, they will increase the nesting of your tree, unlike hooks which are completely flat.

We think Subs can be a neat alternative to hooks, so there is a Sub equivalent to many hooks from `flutter_hooks`.
Replace your `useSomething` with `SubSomething` and youre good to go!

Some hooks may not have an equivalent Sub or the Sub may function slightly differently because it made more sense that way.

## Custom Subs

The package comes with many [inbuilt](#inbuilt-subs) and ready-to-use Subs.
Its also possible to directly use `SubValue` in your code.

If you however wish to create your own reusable Subs, read ahead.

You can get access to `SubValueBuild` and other internal types by importing `package:flutter_sub/developer.dart`.

### SubValue

To create your own Subs easily, you can extend the `SubValue` class.
For example, a simple implementation of [`SubTextEditingController`](#other-subs) can look something like this:

```dart
class SubTextEditingController extends SubValue<TextEditingController> {
  SubTextEditingController({
    String? text,
    super.keys,
    required super.builder,
  }) : super(
          create: () => TextEditingController(text: text),
          dispose: (controller) => controller.dispose(),
        );
}
```

### Widgets in Builder

If you would like to include an extra Widget inside your custom Sub, you can do so by adding it to the builder.

Here is an example of a [`SubValueNotifier`](#listenable-subs) that includes a `ValueListenableBuilder`, so that its child is automatically rebuilt:

```dart
class SubValueNotifier<T> extends SubValue<ValueNotifier<T>> {
  SubValueNotifier({
    required T initialData,
    required SubValueBuild<ValueNotifier<T>> builder,
    super.keys,
  }) : super(
          create: () => ValueNotifier<T>(initialData),
          builder: (context, notifier) => ValueListenableBuilder<T>(
            valueListenable: notifier,
            builder: (context, value) => builder(context, notifier),
          ),
          dispose: (notifier) => notifier.dispose(),
        );
}
```

### SubValue.builder

If your custom Sub needs access to `BuildContext`, for example to access an `InheritedWidget`, you can use the `SubValue.builder` constructor, which will provide `BuildContext` to each function.

### SubValueState

If you have even more special requirements like having a special Mixin on your `State`, you can extend the `SubValueState` of your `SubValue`. An example of this can be seen in [SubTickerProviderMixin](#animation-subs).

This is provided for completeness sake. It might be easier to create a real `StatefulWidget` instead.

## Inbuilt Subs

The package comes with the following inbuilt Subs for your convenience:

### Async Subs

Subs which help using Streams and Futures.

| Name                                                                                                               | Description                                                                               |
| ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- |
| [SubStream](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubStream-class.html)                     | Creates and subscribes to a `Stream` and returns its current state as an `AsyncSnapshot`. |
| [SubStreamController](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubStreamController-class.html) | Creates a `StreamController` which will automatically be disposed.                        |
| [SubSubscriber](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubSubscriber-class.html)             | Subscribes a listener to a `Stream`.                                                      |
| [SubFuture](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubFuture-class.html)                     | Creates and subscribes to a `Future` and returns its current state as an `AsyncSnapshot`. |

### Animation Subs

Subs which help setting up Animations and ChangeNotifiers.

| Name                                                                                                                     | Description                                                            |
| ------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------- |
| [SubTickerProvider](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubTickerProvider-class.html)           | Creates a `TickerProvider`.                                            |
| [SubAnimationController](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubAnimationController-class.html) | Creates an `AnimationController` which will be automatically disposed. |
| [SubAnimator](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubAnimator-class.html)                       | Subscribes to an `Animation` and returns its value.                    |

### Listenable Subs

Subs which help using Listeners, ValueListeners and ValueNotifiers.

| Name                                                                                                         | Description                                                                           |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------- |
| [SubListener](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubListener-class.html)           | Subscribes to a `Listenable` and rebuilds the widget whenever the listener is called. |
| [SubValueListener](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubValueListener-class.html) | Subscribes to a `ValueListenable` and return its value.                               |
| [SubValueNotifier](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubValueNotifier-class.html) | Creates a `ValueNotifier` which will be automatically disposed.                       |

### Other Subs

Subs which create and hold various other controllers and objects commonly used.

| Name                                                                                                                               | Description                                                     |
| ---------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| [SubTextEditingController](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubTextEditingController-class.html)       | Creates and disposes a `TextEditingController`.                 |
| [SubFocusNode](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubFocusNode-class.html)                               | Creates a `FocusNode`.                                          |
| [SubTabController](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubTabController-class.html)                       | Creates and disposes a `TabController`.                         |
| [SubScrollController](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubScrollController-class.html)                 | Creates and disposes a `ScrollController`.                      |
| [SubPageController](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubPageController-class.html)                     | Creates and disposes a `PageController`.                        |
| [SubAppLifecycleState](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubAppLifecycleState-class.html)               | Subscribes to the `AppLifecycleState` and return its value.     |
| [SubTransformationController](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubTransformationController-class.html) | Creates and disposes a `TransformationController`.              |
| [SubPlatformBrightness](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubPlatformBrightness-class.html)             | Subscribes to the platform's `Brightness` and return its value. |

### Hook-alikes

Subs that are similar to React Hooks to ease transition.

| Name                                                                                               | Description                                            |
| -------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| [SubEffect](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubEffect-class.html)     | Useful for side-effects and optionally canceling them. |
| [SubState](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubState-class.html)       | Creates a variable and subscribes to it.               |
| [SubMemoized](https://pub.dev/documentation/flutter_sub/latest/flutter_sub/SubMemoized-class.html) | Caches the instance of a complex object.               |
