import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// source response
class SourceAttributes extends Equatable {
  ///
  const SourceAttributes({
    required this.type,
    required this.amount,
    required this.currency,
    required this.redirect,
    required this.billing,
  });

  ///
  factory SourceAttributes.fromMap(Map<String, dynamic> map) {
    return SourceAttributes(
      type: map['type'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] ?? '',
      redirect: Redirect.fromMap(map['redirect']),
      billing: PayMongoBilling.fromMap(map['billing']),
    );
  }

  ///
  factory SourceAttributes.fromJson(String source) =>
      SourceAttributes.fromMap(json.decode(source));

  ///
  final String type;

  ///
  final double amount;

  ///
  final String currency;

  ///
  final Redirect redirect;

  ///
  final PayMongoBilling billing;

  ///
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

  ///
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount.toCurrency(),
      'currency': currency,
      'redirect': redirect.toMap(),
      'billing': billing.toMap(),
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      type,
      amount,
      currency,
      redirect,
      billing,
    ];
  }
}
