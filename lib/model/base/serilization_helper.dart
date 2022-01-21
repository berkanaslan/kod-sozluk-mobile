DateTime? dateTimeFromTimestamp(dynamic timestamp) {
  if (timestamp is int) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  if (timestamp is DateTime) {
    return timestamp;
  }

  if (timestamp is String) {
    return DateTime.tryParse(timestamp);
  }
}
