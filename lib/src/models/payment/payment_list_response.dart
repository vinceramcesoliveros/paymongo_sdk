import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:paymongo_sdk/src/src.dart';

class PaymentListResponse {
  final bool hasMore;
  final List<PaymentAttributesResponse> data;
  PaymentListResponse({
    required this.hasMore,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'has_more': hasMore,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory PaymentListResponse.fromMap(Map<String, dynamic> map) {
    return PaymentListResponse(
      hasMore: map['has_more'] ?? false,
      data: List<PaymentAttributesResponse>.from(
          map['data']?.map((x) => PaymentAttributesResponse.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentListResponse.fromJson(String source) =>
      PaymentListResponse.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is PaymentListResponse &&
        other.hasMore == hasMore &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => hasMore.hashCode ^ data.hashCode;

  PaymentListResponse copyWith({
    bool? hasMore,
    List<PaymentAttributesResponse>? data,
  }) {
    return PaymentListResponse(
      hasMore: hasMore ?? this.hasMore,
      data: data ?? this.data,
    );
  }
}
