import 'dart:convert';

import 'package:equatable/equatable.dart';

/// {@template query_payments}
/// {@endtemplate query_payments}
class PaymentListQueryParams extends Equatable {
  /// {@macro query_payments}
  const PaymentListQueryParams({
    this.before = "",
    this.after = "",
    this.limit = "10",
  });

  /// {@macro query_payments}
  factory PaymentListQueryParams.fromMap(Map<String, dynamic> map) {
    return PaymentListQueryParams(
      before: map['before'] ?? '',
      after: map['after'] ?? '',
      limit: map['limit'] ?? '',
    );
  }

  /// {@macro query_payments}
  factory PaymentListQueryParams.fromJson(String source) =>
      PaymentListQueryParams.fromMap(json.decode(source));

  /// via resource ID and not by date
  final String before;

  /// via resource ID and not by date
  final String after;

  /// limit of response data
  final String limit;

  /// {@macro query_payments}
  Map<String, String> toMap() {
    return {
      'before': before,
      'after': after,
      'limit': limit,
    };
  }

  /// {@macro query_payments}
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [before, after, limit];
}
