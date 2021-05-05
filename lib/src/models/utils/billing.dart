import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'address.dart';

class PayMongoBilling {
  final String name;
  final String phone;
  final String email;
  final PayMongoAddress address;
  PayMongoBilling({
    @required this.name,
    @required this.phone,
    @required this.email,
    @required this.address,
  });

  PayMongoBilling copyWith({
    String name,
    String phone,
    String email,
    PayMongoAddress address,
  }) {
    return PayMongoBilling(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address.toMap(),
    };
  }

  factory PayMongoBilling.fromMap(Map<String, dynamic> map) {
    return PayMongoBilling(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: PayMongoAddress.fromMap(map['address']) ?? PayMongoAddress(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PayMongoBilling.fromJson(String source) =>
      PayMongoBilling.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayMongoBilling(name: $name, phone: $phone, email: $email, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PayMongoBilling &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^ phone.hashCode ^ email.hashCode ^ address.hashCode;
  }
}
