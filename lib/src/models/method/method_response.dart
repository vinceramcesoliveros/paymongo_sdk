import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

class PaymentMethodResponse {
  final String id;
  final String type;
  final PaymentMethodAttributesResponse attributes;
  const PaymentMethodResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  factory PaymentMethodResponse.fromMap(Map<String, dynamic> map) {
    return PaymentMethodResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: PaymentMethodAttributesResponse.fromMap(map['attributes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodResponse.fromJson(String source) =>
      PaymentMethodResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentMethodResponse(id: $id, type: $type, attributes: $attributes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethodResponse &&
        other.id == id &&
        other.type == type &&
        other.attributes == attributes;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ attributes.hashCode;
}

class PaymentMethodAttributesResponse extends Equatable {
  const PaymentMethodAttributesResponse({
    this.livemode = false,
    this.type = 'card',
    required this.billing,
    required this.createdAt,
    required this.updatedAt,
    required this.details,
    required this.metadata,
  });

  factory PaymentMethodAttributesResponse.fromMap(Map<String, dynamic> map) {
    return PaymentMethodAttributesResponse(
      livemode: map['livemode'] ?? false,
      type: map['type'] ?? '',
      billing: PayMongoBilling.fromMap(map['billing']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      details: PaymentMethodDetails.fromMap(map['details']),
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodAttributesResponse.fromJson(String source) =>
      PaymentMethodAttributesResponse.fromMap(json.decode(source));

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

  final bool livemode;
  final String type;
  final PayMongoBilling billing;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PaymentMethodDetails details;
  final Map<String, dynamic> metadata;

  Map<String, dynamic> toMap() {
    return {
      'livemode': livemode,
      'type': type,
      'billing': billing.toMap(),
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'details': details.toMap(),
      'metadata': metadata,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
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
