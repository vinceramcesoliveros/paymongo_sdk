import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/src/models/models.dart';

class ListAllRefundQueryParams extends Equatable {
  final String paymentId;
  final String? before;
  final String? after;
  final String? limit;
  const ListAllRefundQueryParams({
    required this.paymentId,
    this.before,
    this.after,
    this.limit,
  });

  ListAllRefundQueryParams copyWith({
    String? id,
    String? before,
    String? after,
    String? limit,
  }) {
    return ListAllRefundQueryParams(
      paymentId: id ?? paymentId,
      before: before ?? this.before,
      after: after ?? this.after,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data.attributes.payment_id': paymentId,
      'data.attributes.before': before,
      'data.attributes.after': after,
      'data.attributes.limit': limit,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ListAllRefundQueryParams(id: $paymentId, before: $before, after: $after, limit: $limit)';
  }

  @override
  List<Object?> get props => [paymentId, before, after, limit];
}

class ListAllRefundResponse extends Equatable {
  final bool hasMore;
  final List<RefundResponseAttributes> data;
  const ListAllRefundResponse({
    required this.hasMore,
    required this.data,
  });

  ListAllRefundResponse copyWith({
    bool? hasMore,
    List<RefundResponseAttributes>? data,
  }) {
    return ListAllRefundResponse(
      hasMore: hasMore ?? this.hasMore,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hasMore': hasMore,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory ListAllRefundResponse.fromMap(Map<String, dynamic> map) {
    return ListAllRefundResponse(
      hasMore: map['hasMore'] ?? false,
      data: List<RefundResponseAttributes>.from(
        map['data']?.map((x) => RefundResponseAttributes.fromMap(x)) ??
            const [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListAllRefundResponse.fromJson(String source) =>
      ListAllRefundResponse.fromMap(json.decode(source));

  @override
  String toString() => 'ListAllRefundResponse(hasMore: $hasMore, data: $data)';

  @override
  List<Object> get props => [hasMore, data];
}
