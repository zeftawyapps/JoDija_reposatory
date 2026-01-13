import 'package:cloud_firestore/cloud_firestore.dart';

/// Parse Firebase timestamp from various formats
DateTime parseFirebaseTimestamp(dynamic value) {
  if (value == Timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(value['_seconds'] * 1000);

  }


  if (value is String) {
    return DateTime.parse(value);
  } else if (value is int) {
    // Unix timestamp in milliseconds
    return DateTime.fromMillisecondsSinceEpoch(value);
  } else if (value is Map && value.containsKey('_seconds')) {
    // Firestore Timestamp serialized as map
    return DateTime.fromMillisecondsSinceEpoch(value['_seconds'] * 1000);
  } else if (value is DateTime) {
    return value;
  }
  throw ArgumentError('Unsupported timestamp format: $value');
}

extension FirebaseTimestampParsing on DateTime {
  static DateTime fromFirebase(dynamic value) {
    return parseFirebaseTimestamp(value);
  }
}