import 'dart:convert';

import 'package:paymongo_sdk/paymongo_sdk.dart';

class PaymentResource {
  final String? id;
  final String? source;
  final PaymentMethodBilling? billing;
  PaymentResource({
    this.id,
    this.source,
    this.billing,
  });

  PaymentResource copyWith({
    String? id,
    String? source,
    PaymentMethodBilling? billing,
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
      'billing': billing!.toMap(),
    };
  }

  factory PaymentResource.fromMap(Map<String, dynamic> map) {
    return PaymentResource(
      id: map['id'] ?? '',
      source: map['source'] ?? '',
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
