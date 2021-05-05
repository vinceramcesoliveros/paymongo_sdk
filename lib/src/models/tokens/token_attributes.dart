import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../utils/billing.dart';

class PayMongoTokenAttributes {
  final String number;
  final int expireMonth;
  final int expireYear;
  final String cvc;
  final PayMongoBilling billing;
  final String name;
  final String email;
  final String phone;
  PayMongoTokenAttributes({
    @required this.number,
    @required this.expireMonth,
    @required this.expireYear,
    @required this.cvc,
    this.billing,
    this.name,
    this.email,
    this.phone,
  });

  PayMongoTokenAttributes copyWith({
    String number,
    int expireMonth,
    int expireYear,
    String cvc,
    PayMongoBilling billing,
    String name,
    String email,
    String phone,
  }) {
    return PayMongoTokenAttributes(
      number: number ?? this.number,
      expireMonth: expireMonth ?? this.expireMonth,
      expireYear: expireYear ?? this.expireYear,
      cvc: cvc ?? this.cvc,
      billing: billing ?? this.billing,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'expireMonth': expireMonth,
      'expireYear': expireYear,
      'cvc': cvc,
      'billing': billing.toMap(),
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory PayMongoTokenAttributes.fromMap(Map<String, dynamic> map) {
    return PayMongoTokenAttributes(
      number: map['number'] ?? '',
      expireMonth: map['expireMonth'] ?? 0,
      expireYear: map['expireYear'] ?? 0,
      cvc: map['cvc'] ?? '',
      billing: PayMongoBilling.fromMap(map['billing']),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PayMongoTokenAttributes.fromJson(String source) =>
      PayMongoTokenAttributes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayMongoTokenAttributes(number: $number, expireMonth: $expireMonth, expireYear: $expireYear, cvc: $cvc, billing: $billing, name: $name, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PayMongoTokenAttributes &&
        other.number == number &&
        other.expireMonth == expireMonth &&
        other.expireYear == expireYear &&
        other.cvc == cvc &&
        other.billing == billing &&
        other.name == name &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        expireMonth.hashCode ^
        expireYear.hashCode ^
        cvc.hashCode ^
        billing.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode;
  }
}
