DateTime? fromTimeStamp(int? timestamp) {
  if (timestamp != null) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
  return null;
}
