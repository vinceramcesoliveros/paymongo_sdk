import 'dart:convert';

import '../models.dart';

class PaymentMethodResource {
  final String? id;
  final String? type;
  final PaymentMethod? attributes;
  const PaymentMethodResource({
    this.id,
    this.type,
    this.attributes,
  });

  PaymentMethodResource copyWith({
    String? id,
    String? type,
    PaymentMethod? attributes,
  }) {
    return PaymentMethodResource(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes!.toMap(),
    };
  }

  factory PaymentMethodResource.fromMap(Map<String, dynamic> map) {
    return PaymentMethodResource(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: PaymentMethod.fromMap(map['attributes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodResource.fromJson(String source) =>
      PaymentMethodResource.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentMethodResource(id: $id, type: $type, attributes: $attributes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethodResource &&
        other.id == id &&
        other.type == type &&
        other.attributes == attributes;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ attributes.hashCode;
}
