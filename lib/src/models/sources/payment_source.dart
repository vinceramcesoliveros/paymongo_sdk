import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentAttributeSourceResponse extends Equatable {
  final String id;
  final String type;
  final String brand;
  final String country;
  final String last4;
  const PaymentAttributeSourceResponse({
    required this.id,
    required this.type,
    required this.brand,
    required this.country,
    required this.last4,
  });

  PaymentAttributeSourceResponse copyWith({
    String? id,
    String? type,
    String? brand,
    String? country,
    String? last4,
  }) {
    return PaymentAttributeSourceResponse(
      id: id ?? this.id,
      type: type ?? this.type,
      brand: brand ?? this.brand,
      country: country ?? this.country,
      last4: last4 ?? this.last4,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'brand': brand,
      'country': country,
      'last4': last4,
    };
  }

  factory PaymentAttributeSourceResponse.fromMap(Map<String, dynamic> map) {
    return PaymentAttributeSourceResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      brand: map['brand'] ?? '',
      country: map['country'] ?? '',
      last4: map['last4'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentAttributeSourceResponse.fromJson(String source) =>
      PaymentAttributeSourceResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentAttributeSourceResponse(id: $id, type: $type, brand: $brand, country: $country, last4: $last4)';
  }

  @override
  List<Object> get props {
    return [
      id,
      type,
      brand,
      country,
      last4,
    ];
  }
}
