import 'dart:convert';

import 'package:paymongo_sdk/src/src.dart';

/// {@template payment_list_response}
/// {@endtemplate}
class PaymentListResponse {
  /// {@macro payment_list_response}
  const PaymentListResponse({
    required this.hasMore,
    required this.data,
  });

  /// {@macro payment_list_response}
  factory PaymentListResponse.fromMap(Map<String, dynamic> map) {
    return PaymentListResponse(
      hasMore: map['has_more'] ?? false,
      data: List<CreatePaymentResponse>.from(
          map['data']?.map((x) => CreatePaymentResponse.fromMap(x)) ??
              const []),
    );
  }

  /// {@macro payment_list_response}
  factory PaymentListResponse.fromJson(String source) =>
      PaymentListResponse.fromMap(json.decode(source));

  /// if has more data
  final bool hasMore;

  /// payments
  final List<CreatePaymentResponse> data;

  /// {@macro payment_list_response}
  Map<String, dynamic> toMap() {
    return {
      'has_more': hasMore,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  /// {@macro payment_list_response}
  String toJson() => json.encode(toMap());

  /// {@macro payment_list_response}
  PaymentListResponse copyWith({
    bool? hasMore,
    List<CreatePaymentResponse>? data,
  }) {
    return PaymentListResponse(
      hasMore: hasMore ?? this.hasMore,
      data: data ?? this.data,
    );
  }
}
