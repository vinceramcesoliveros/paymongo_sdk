import 'dart:convert';

import 'package:paymongo_sdk/paymongo_sdk.dart';

class PaymentResource {
  final int id;
  final int source;
  final PaymentMethodBilling billing;
  PaymentResource({
    this.id,
    this.source,
    this.billing,
  });

  PaymentResource copyWith({
    int id,
    int source,
    PaymentMethodBilling billing,
  }) {
    return PaymentResource(
      id: id ?? this.id,
      source: source ?? this.source,
      billing: billing ?? this.billing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'billing': billing.toMap(),
    };
  }

  factory PaymentResource.fromMap(Map<String, dynamic> map) {
    return PaymentResource(
      id: map['id'] ?? 0,
      source: map['source'] ?? 0,
      billing: PaymentMethodBilling.fromMap(map['billing']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentResource.fromJson(String source) =>
      PaymentResource.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentResource(id: $id, source: $source, billing: $billing)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentResource &&
        other.id == id &&
        other.source == source &&
        other.billing == billing;
  }

  @override
  int get hashCode => id.hashCode ^ source.hashCode ^ billing.hashCode;
}
