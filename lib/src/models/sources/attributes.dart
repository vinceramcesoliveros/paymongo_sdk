import 'dart:convert';

import '../models.dart';

class SourceAttributes {
  final String type;
  final double amount;
  final String currency;
  final Redirect redirect;
  final PayMongoBilling billing;
  const SourceAttributes({
    required this.type,
    required this.amount,
    required this.currency,
    required this.redirect,
    required this.billing,
  });

  SourceAttributes copyWith({
    String? type,
    double? amount,
    String? currency,
    Redirect? redirect,
    PayMongoBilling? billing,
  }) {
    return SourceAttributes(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      redirect: redirect ?? this.redirect,
      billing: billing ?? this.billing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount.toCurrency(),
      'currency': currency,
      'redirect': redirect.toMap(),
      'billing': billing.toMap(),
    };
  }

  factory SourceAttributes.fromMap(Map<String, dynamic> map) {
    return SourceAttributes(
      type: map['type'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] ?? '',
      redirect: Redirect.fromMap(map['redirect']),
      billing: PayMongoBilling.fromMap(map['billing']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SourceAttributes.fromJson(String source) =>
      SourceAttributes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Sources(type: $type, amount: $amount, currency: $currency, redirect: $redirect, billing: $billing)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SourceAttributes &&
        other.type == type &&
        other.amount == amount &&
        other.currency == currency &&
        other.redirect == redirect &&
        other.billing == billing;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        redirect.hashCode ^
        billing.hashCode;
  }
}
