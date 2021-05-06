import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../utils/address.dart';

class PaymentMethod {
  final PaymentMethodBilling billing;
  final PayMongoDetails details;
  final String type;
  const PaymentMethod({
    this.billing,
    this.details,
    this.type = 'card',
  });

  PaymentMethod copyWith({
    PaymentMethodBilling billing,
    PayMongoDetails details,
    String type,
  }) {
    return PaymentMethod(
      billing: billing ?? this.billing,
      details: details ?? this.details,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'billing': billing.toMap(),
      'details': details.toMap(),
      'type': type ?? 'card',
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      billing: PaymentMethodBilling.fromMap(map['billing']),
      details: PayMongoDetails.fromMap(map['details']),
      type: map['type'] ?? 'card',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source));

  @override
  String toString() =>
      'PayMongoAttributes(billing: $billing, details: $details, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethod &&
        other.billing == billing &&
        other.details == details &&
        other.type == type;
  }

  @override
  int get hashCode => billing.hashCode ^ details.hashCode ^ type.hashCode;
}

class PaymentMethodBilling {
  final PayMongoAddress address;
  final PayMongoDetails details;
  final bool liveMode;

  final Map<String, dynamic> metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  PaymentMethodBilling({
    this.address,
    this.details,
    this.liveMode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  PaymentMethodBilling copyWith({
    PayMongoAddress address,
    PayMongoDetails details,
    bool liveMode,
    Map<String, dynamic> metadata,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return PaymentMethodBilling(
      address: address ?? this.address,
      details: details ?? this.details,
      liveMode: liveMode ?? this.liveMode,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address.toMap(),
      'details': details.toMap(),
      'livemode': liveMode,
      'metadata': metadata,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory PaymentMethodBilling.fromMap(Map<String, dynamic> map) {
    return PaymentMethodBilling(
      address: PayMongoAddress.fromMap(map['address']),
      details: PayMongoDetails.fromMap(map['details']),
      liveMode: map['livemode'] ?? false,
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodBilling.fromJson(String source) =>
      PaymentMethodBilling.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentMethodBilling(address: $address, details: $details, liveMode: $liveMode, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethodBilling &&
        other.address == address &&
        other.details == details &&
        other.liveMode == liveMode &&
        mapEquals(other.metadata, metadata) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        details.hashCode ^
        liveMode.hashCode ^
        metadata.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class PayMongoDetails {
  final String last4;
  final int expireMonth;
  final int expireYear;
  final String cardNumber;

  PayMongoDetails({
    @required this.last4,
    @required this.expireMonth,
    @required this.expireYear,
    @required this.cardNumber,
  });

  PayMongoDetails copyWith({
    String last4,
    int expireMonth,
    int expireYear,
    String cardNumber,
  }) {
    return PayMongoDetails(
      last4: last4 ?? this.last4,
      expireMonth: expireMonth ?? this.expireMonth,
      expireYear: expireYear ?? this.expireYear,
      cardNumber: cardNumber ?? this.cardNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'last4': last4,
      'exp_month': expireMonth,
      'exp_year': expireYear,
      'card_number': cardNumber,
    };
  }

  factory PayMongoDetails.fromMap(Map<String, dynamic> map) {
    return PayMongoDetails(
      last4: map['last4'] ?? '',
      expireMonth: map['exp_month'] ?? 0,
      expireYear: map['exp_year'] ?? 0,
      cardNumber: map['card_number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PayMongoDetails.fromJson(String source) =>
      PayMongoDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayMongoDetails(last4: $last4, expireMonth: $expireMonth, expireYear: $expireYear, cardNumber: $cardNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PayMongoDetails &&
        other.last4 == last4 &&
        other.expireMonth == expireMonth &&
        other.expireYear == expireYear &&
        other.cardNumber == cardNumber;
  }

  @override
  int get hashCode {
    return last4.hashCode ^
        expireMonth.hashCode ^
        expireYear.hashCode ^
        cardNumber.hashCode;
  }
}
