/// Compares two iterables against each other.
///
/// Returns true if:
/// - the iterables are both null.
/// - the iterables are equal*.
/// - the iterables have the same length and all elements and their positions are equal*.
///
/// *Equality is checked with the equals operator.
///
/// Returns false otherwise.
bool iterablesAreEqual<T>(Iterable<T>? a, Iterable<T>? b) {
  // same instance
  if (a == b) return true;
  // null or different length
  if (a == null || b == null || a.length != b.length) return false;

  Iterator<T> ia = a.iterator;
  Iterator<T> ib = b.iterator;
  // every element matches
  while (true) {
    if (!ia.moveNext() || !ib.moveNext()) return true;
    if (ia.current != ib.current) return false;
  }
}
