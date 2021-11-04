/// currency extension
extension PayMongoCurrency on num {
  /// convert amount multiplied by 100 as a requirement for paymongo api.
  int toCurrency() {
    return (toDouble() * 100).toInt();
  }
}
