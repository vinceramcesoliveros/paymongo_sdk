import 'dart:convert';

import 'package:flutter/foundation.dart';

class Redirect {
  final String success;
  final String failed;
  Redirect({
    @required this.success,
    @required this.failed,
  });

  Redirect copyWith({
    String success,
    String failed,
  }) {
    return Redirect(
      success: success ?? this.success,
      failed: failed ?? this.failed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'failed': failed,
    };
  }

  factory Redirect.fromMap(Map<String, dynamic> map) {
    return Redirect(
      success: map['success'] ?? '',
      failed: map['failed'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Redirect.fromJson(String source) =>
      Redirect.fromMap(json.decode(source));

  @override
  String toString() => 'Redirect(success: $success, failed: $failed)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Redirect &&
        other.success == success &&
        other.failed == failed;
  }

  @override
  int get hashCode => success.hashCode ^ failed.hashCode;
}
