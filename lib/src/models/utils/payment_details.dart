import 'dart:convert';

import 'package:equatable/equatable.dart';

///
class PayMongoPaymentDetails extends Equatable {
  ///
  const PayMongoPaymentDetails({
    this.cardNumber,
    this.expMonth,
    this.expYear,
    this.cvc,
  });

  ///
  factory PayMongoPaymentDetails.fromMap(Map<String, dynamic> map) {
    return PayMongoPaymentDetails(
      cardNumber: map['card_number'] ?? 0,
      expMonth: map['exp_month'] ?? 0,
      expYear: map['exp_year'] ?? 0,
      cvc: map['cvc'] ?? '',
    );
  }

  ///
  factory PayMongoPaymentDetails.fromJson(String source) =>
      PayMongoPaymentDetails.fromMap(json.decode(source));

  ///
  final int? cardNumber;

  ///
  final int? expMonth;

  ///
  final int? expYear;

  ///
  final String? cvc;

  ///
  PayMongoPaymentDetails copyWith({
    int? cardNumber,
    int? expMonth,
    int? expYear,
    String? cvc,
  }) {
    return PayMongoPaymentDetails(
      cardNumber: cardNumber ?? this.cardNumber,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      cvc: cvc ?? this.cvc,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'card_number': cardNumber,
      'exp_month': expMonth,
      'exp_year': expYear,
      'cvc': cvc,
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [cardNumber, expMonth, expYear, cvc];
}
