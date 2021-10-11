import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

///{@template payment_method}
class PaymentMethodAttributes extends Equatable {
  /// {@macro payment_method}
  const PaymentMethodAttributes({
    this.type = 'card',
    required this.details,
    required this.billing,
  });
  final String type;
  final PaymentMethodDetails details;
  final PayMongoBilling billing;
  @override
  List<Object> get props => [type, details, billing];

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'details': details.toMap(),
      'billing': billing.toMap(),
    };
  }

  factory PaymentMethodAttributes.fromMap(Map<String, dynamic> map) {
    return PaymentMethodAttributes(
      type: map['type'] ?? '',
      details: PaymentMethodDetails.fromMap(map['details']),
      billing: PayMongoBilling.fromMap(map['billing']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodAttributes.fromJson(String source) =>
      PaymentMethodAttributes.fromMap(json.decode(source));

  PaymentMethodAttributes copyWith({
    String? type,
    PaymentMethodDetails? details,
    PayMongoBilling? billing,
  }) {
    return PaymentMethodAttributes(
      type: type ?? this.type,
      details: details ?? this.details,
      billing: billing ?? this.billing,
    );
  }

  @override
  bool get stringify => true;
}

class PaymentMethodDetails extends Equatable {
  final String cardNumber;
  final int expMonth;
  final int expYear;
  final String cvc;
  const PaymentMethodDetails({
    required this.cardNumber,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
  });

  @override
  List<Object> get props => [cardNumber, expMonth, expYear, cvc];

  PaymentMethodDetails copyWith({
    String? cardNumber,
    int? expMonth,
    int? expYear,
    String? cvc,
  }) {
    return PaymentMethodDetails(
      cardNumber: cardNumber ?? this.cardNumber,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      cvc: cvc ?? this.cvc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'card_number': cardNumber,
      'exp_month': expMonth,
      'exp_year': expYear,
      'cvc': cvc,
    };
  }

  factory PaymentMethodDetails.fromMap(Map<String, dynamic> map) {
    return PaymentMethodDetails(
      cardNumber: map['card_number'] ?? '',
      expMonth: map['exp_month'] ?? 0,
      expYear: map['exp_ear'] ?? 0,
      cvc: map['cvc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodDetails.fromJson(String source) =>
      PaymentMethodDetails.fromMap(json.decode(source));
}

class PaymentMethodBilling extends Equatable {
  final PayMongoAddress? address;
  final PayMongoDetails? details;
  final bool? liveMode;

  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const PaymentMethodBilling({
    this.address,
    this.details,
    this.liveMode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  PaymentMethodBilling copyWith({
    PayMongoAddress? address,
    PayMongoDetails? details,
    bool? liveMode,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
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
      'address': address!.toMap(),
      'details': details!.toMap(),
      'livemode': liveMode,
      'metadata': metadata,
      'created_at': createdAt!.millisecondsSinceEpoch,
      'updated_at': updatedAt!.millisecondsSinceEpoch,
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
  List<Object?> get props {
    return [
      address,
      details,
      liveMode,
      metadata,
      createdAt,
      updatedAt,
    ];
  }
}

class PayMongoDetails {
  final String last4;
  final int expireMonth;
  final int expireYear;
  final String cardNumber;

  PayMongoDetails({
    required this.last4,
    required this.expireMonth,
    required this.expireYear,
    required this.cardNumber,
  });

  PayMongoDetails copyWith({
    String? last4,
    int? expireMonth,
    int? expireYear,
    String? cardNumber,
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
