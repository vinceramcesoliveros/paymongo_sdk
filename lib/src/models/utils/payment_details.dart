import 'dart:convert';

class PayMongoPaymentDetails {
  final int? cardNumber;
  final int? expMonth;
  final int? expYear;
  final String? cvc;
  PayMongoPaymentDetails({
    this.cardNumber,
    this.expMonth,
    this.expYear,
    this.cvc,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'card_number': cardNumber,
      'exp_month': expMonth,
      'exp_year': expYear,
      'cvc': cvc,
    };
  }

  factory PayMongoPaymentDetails.fromMap(Map<String, dynamic> map) {
    return PayMongoPaymentDetails(
      cardNumber: map['card_number'] ?? 0,
      expMonth: map['exp_month'] ?? 0,
      expYear: map['exp_year'] ?? 0,
      cvc: map['cvc'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PayMongoPaymentDetails.fromJson(String source) =>
      PayMongoPaymentDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayMongoPaymentDetails(cardNumber: $cardNumber, expMonth: $expMonth, expYear: $expYear, cvc: $cvc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PayMongoPaymentDetails &&
        other.cardNumber == cardNumber &&
        other.expMonth == expMonth &&
        other.expYear == expYear &&
        other.cvc == cvc;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
        expMonth.hashCode ^
        expYear.hashCode ^
        cvc.hashCode;
  }
}
