/// convert enum to string
extension PaymongoEnums on Enum {
  /// converts enum to string
  String describeEnum() {
    final description = toString();
    final indexOfDot = description.indexOf('.');
    assert(
      indexOfDot != -1 && indexOfDot < description.length - 1,
      'The provided object "$this" is not an enum.',
    );
    return description.substring(indexOfDot + 1);
  }
}
