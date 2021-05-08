import 'dart:convert';

import '../models.dart';

class Source {
  final String type;
  final double amount;
  final String currency;
  final Redirect redirect;
  final PayMongoBilling billing;
  Source({
    required this.type,
    required this.amount,
    required this.currency,
    required this.redirect,
    required this.billing,
  });

  Source copyWith({
    String? type,
    double? amount,
    String? currency,
    Redirect? redirect,
    PayMongoBilling? billing,
  }) {
    return Source(
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

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      type: map['type'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] ?? '',
      redirect: Redirect.fromMap(map['redirect']),
      billing: PayMongoBilling.fromMap(map['billing']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) => Source.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Sources(type: $type, amount: $amount, currency: $currency, redirect: $redirect, billing: $billing)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Source &&
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
