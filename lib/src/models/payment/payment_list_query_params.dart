import 'dart:convert';

class PaymentListQueryParams {
  final String before;
  final String after;
  final String limit;
  PaymentListQueryParams({
    this.before = "",
    this.after = "",
    this.limit = "10",
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentListQueryParams &&
        other.before == before &&
        other.after == after &&
        other.limit == limit;
  }

  @override
  int get hashCode => before.hashCode ^ after.hashCode ^ limit.hashCode;

  @override
  String toString() =>
      'PaymentListQueryParams(before: $before, after: $after, limit: $limit)';

  Map<String, String> toMap() {
    return {
      'before': before,
      'after': after,
      'limit': limit,
    };
  }

  factory PaymentListQueryParams.fromMap(Map<String, dynamic> map) {
    return PaymentListQueryParams(
      before: map['before'] ?? '',
      after: map['after'] ?? '',
      limit: map['limit'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentListQueryParams.fromJson(String source) =>
      PaymentListQueryParams.fromMap(json.decode(source));
}
