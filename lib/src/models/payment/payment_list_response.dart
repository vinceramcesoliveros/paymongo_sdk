import 'dart:convert';

import 'package:equatable/equatable.dart';
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
      data: List<PaymentListAllResponse>.from(
        map['data']?.map(PaymentListAllResponse.fromMap) ?? const [],
      ),
    );
  }

  /// {@macro payment_list_response}
  factory PaymentListResponse.fromJson(String source) =>
      PaymentListResponse.fromMap(json.decode(source));

  /// if has more data
  final bool hasMore;

  /// payments
  final List<PaymentListAllResponse> data;

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
    List<PaymentListAllResponse>? data,
  }) {
    return PaymentListResponse(
      hasMore: hasMore ?? this.hasMore,
      data: data ?? this.data,
    );
  }
}

/// {@template payment_list_all_response}
/// {@endtemplate}
class PaymentListAllResponse extends Equatable {
  /// {@macro payment_list_all_response}
  const PaymentListAllResponse({
    required this.hasMore,
    required this.data,
  });

  /// {@macro payment_list_all_response}
  factory PaymentListAllResponse.fromMap(Map<String, dynamic> map) {
    return PaymentListAllResponse(
      hasMore: map['hasMore'] ?? false,
      data: List<Map<String, dynamic>>.from(
        map['data'] ?? [],
      ).map(PaymentDataResponse.fromMap).toList(),
    );
  }

  /// {@macro payment_list_all_response}
  factory PaymentListAllResponse.fromJson(String source) =>
      PaymentListAllResponse.fromMap(json.decode(source));

  ///
  final bool hasMore;

  /// response attributes.
  final List<PaymentDataResponse?> data;

  ///
  PaymentListAllResponse copyWith({
    bool? hasMore,
    List<PaymentDataResponse?>? data,
  }) {
    return PaymentListAllResponse(
      hasMore: hasMore ?? this.hasMore,
      data: data ?? this.data,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'hasMore': hasMore,
      'data': data.map((x) => x?.toMap()).toList(),
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [hasMore, data];
}

///{@template payment_list_response}
/// response from listAll method.
///{@endtemplate}
class PaymentDataResponse extends Equatable {
  /// {@macro payment_list_response}
  const PaymentDataResponse({
    required this.id,
    required this.type,
    this.attributes,
  });

  /// {@macro payment_list_response}
  factory PaymentDataResponse.fromMap(Map<String, dynamic> map) {
    return PaymentDataResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: map['attributes'] != null
          ? PaymentAttributesResponse.fromMap(map['attributes'])
          : null,
    );
  }

  /// {@macro payment_list_response}
  factory PaymentDataResponse.fromJson(String source) =>
      PaymentDataResponse.fromMap(json.decode(source));

  /// payment id.
  final String id;

  /// payment type.
  final String type;

  /// payment attributes
  final PaymentAttributesResponse? attributes;

  ///
  PaymentDataResponse copyWith({
    String? id,
    String? type,
    PaymentAttributesResponse? attributes,
  }) {
    return PaymentDataResponse(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes?.toMap(),
    };
  }

  ///
  String toJson() => json.encode(toMap());
  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, type, attributes];
}
