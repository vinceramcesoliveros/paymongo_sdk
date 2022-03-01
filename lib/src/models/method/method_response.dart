import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// {@template payment_method_response}
/// {@endtemplate}
class PaymentMethodResponse extends Equatable {
  /// {@macro payment_method_response}
  const PaymentMethodResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  /// {@macro payment_method_response}
  factory PaymentMethodResponse.fromMap(Map<String, dynamic> map) {
    return PaymentMethodResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: PaymentMethodAttributesResponse.fromMap(map['attributes']),
    );
  }

  /// {@macro payment_method_response}
  factory PaymentMethodResponse.fromJson(String source) =>
      PaymentMethodResponse.fromMap(json.decode(source));

  ///
  final String id;

  ///
  final String type;

  ///
  final PaymentMethodAttributesResponse attributes;

  /// {@macro payment_method_response}
  PaymentMethodResponse copyWith({
    String? id,
    String? type,
    PaymentMethodAttributesResponse? attributes,
  }) {
    return PaymentMethodResponse(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  /// {@macro payment_method_response}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  /// {@macro payment_method_response}
  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'PaymentMethodResponse(id: $id, type: $type, attributes: $attributes)';

  @override
  List<Object> get props => [id, type, attributes];
}

///{@template payment_response_attributes}
///{@endtemplate}
class PaymentMethodAttributesResponse extends Equatable {
  ///{@macro payment_response_attributes}
  const PaymentMethodAttributesResponse({
    this.livemode = false,
    this.type = 'card',
    required this.billing,
    required this.createdAt,
    required this.updatedAt,
    required this.details,
    required this.metadata,
  });

  ///{@macro payment_response_attributes}
  factory PaymentMethodAttributesResponse.fromMap(Map<String, dynamic> map) {
    return PaymentMethodAttributesResponse(
      livemode: map['livemode'] ?? false,
      type: map['type'] ?? '',
      billing: PayMongoBilling.fromMap(map['billing']),
      createdAt: fromTimeStamp(map['created_at']) ?? DateTime.now(),
      updatedAt: fromTimeStamp(map['updated_at']) ?? DateTime.now(),
      details: map['details'] != null
          ? PaymentMethodDetails.fromMap(map['details'])
          : null,
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  ///{@macro payment_response_attributes}
  factory PaymentMethodAttributesResponse.fromJson(String source) =>
      PaymentMethodAttributesResponse.fromMap(json.decode(source));

  ///{@macro payment_response_attributes}
  String toJson() => json.encode(toMap());

  ///{@macro payment_response_attributes}
  PaymentMethodAttributesResponse copyWith({
    bool? livemode,
    String? type,
    PayMongoBilling? billing,
    DateTime? createdAt,
    DateTime? updatedAt,
    PaymentMethodDetails? details,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentMethodAttributesResponse(
      livemode: livemode ?? this.livemode,
      type: type ?? this.type,
      billing: billing ?? this.billing,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      details: details ?? this.details,
      metadata: metadata ?? this.metadata,
    );
  }

  ///
  final bool livemode;

  ///
  final String type;

  ///
  final PayMongoBilling billing;

  ///
  final DateTime createdAt;

  ///
  final DateTime updatedAt;

  ///
  final PaymentMethodDetails? details;

  ///
  final Map<String, dynamic> metadata;

  ///{@macro payment_response_attributes}
  Map<String, dynamic> toMap() {
    return {
      'livemode': livemode,
      'type': type,
      'billing': billing.toMap(),
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'details': details?.toMap(),
      'metadata': metadata,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      livemode,
      type,
      billing,
      createdAt,
      updatedAt,
      details,
      metadata,
    ];
  }
}
