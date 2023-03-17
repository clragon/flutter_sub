import 'package:flutter/widgets.dart';
import 'package:flutter_sub/src/collection.dart';
import 'package:flutter_sub/src/sub_value.dart';

/// The [State] of a [SubValue].
/// Can be extended for special cases where a [SubValue] with a Mixin is desired.
class SubValueState<T> extends State<SubValue<T>> {
  /// The current keys for the value of this Builder.
  @protected
  List<Object?>? keys;

  /// The current value of this Builder.
  @protected
  T? value;

  /// Recreates the value if necessary.
  /// Current keys are compared against new Keys.
  T recreate(T? current) {
    List<Object?>? updatedKeys = widget.keys?.call(context) ?? [];
    bool hasChanged = !iterablesAreEqual(keys, updatedKeys);
    if (hasChanged) {
      if (current != null) {
        widget.dispose?.call(context, current);
      }
      current = widget.create(context);
      keys = updatedKeys;
    }
    return current as T;
  }

  /// Updates the value.
  /// This can be anything from changing a property on the value to completely replacing it,
  /// or doing nothing at all.
  T update(T current) {
    if (widget.update != null) {
      T updated = widget.update!(context, current);
      if (current != updated) {
        widget.dispose?.call(context, current);
        current = updated;
      }
    }
    return current;
  }

  @override
  void dispose() {
    widget.dispose?.call(context, value as T);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        value = update(recreate(value)),
      );
}
