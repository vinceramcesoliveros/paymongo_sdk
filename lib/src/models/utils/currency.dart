extension PayMongoCurrency on num {
  int toCurrency() {
    return (toDouble() * 100).toInt();
  }
}
