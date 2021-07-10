import 'dart:convert';

class Redirect {
  final String success;
  final String failed;
  final String? checkoutUrl;
  const Redirect({
    required this.success,
    required this.failed,
    this.checkoutUrl,
  });

  Redirect copyWith({
    String? success,
    String? failed,
    String? checkoutUrl,
  }) {
    return Redirect(
      success: success ?? this.success,
      failed: failed ?? this.failed,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'failed': failed,
      'checkout_url': checkoutUrl,
    };
  }

  factory Redirect.fromMap(Map<String, dynamic> map) {
    return Redirect(
      success: map['success'] ?? '',
      failed: map['failed'] ?? '',
      checkoutUrl: map['checkout_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Redirect.fromJson(String source) =>
      Redirect.fromMap(json.decode(source));

  @override
  String toString() =>
      'Redirect(success: $success, failed: $failed, checkoutUrl: $checkoutUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Redirect &&
        other.success == success &&
        other.failed == failed &&
        other.checkoutUrl == checkoutUrl;
  }

  @override
  int get hashCode => success.hashCode ^ failed.hashCode ^ checkoutUrl.hashCode;
}
