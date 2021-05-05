import 'dart:convert';
import '../utils/currency.dart';
import 'package:flutter/foundation.dart';

class PaymentIntentAttributes {
  final double amount;
  final List<String> paymentMethodAllowed;
  final PaymentIntentOptions options;
  PaymentIntentAttributes({
    @required this.amount,
    @required this.paymentMethodAllowed,
    @required this.options,
  });

  PaymentIntentAttributes copyWith({
    double amount,
    List<String> paymentMethodAllowed,
    PaymentIntentOptions options,
  }) {
    return PaymentIntentAttributes(
      amount: amount ?? this.amount,
      paymentMethodAllowed: paymentMethodAllowed ?? this.paymentMethodAllowed,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount.toCurrency(),
      'payment_method_allowed': paymentMethodAllowed ?? ['card'],
      'payment_method_options': options.toMap(),
    };
  }

  factory PaymentIntentAttributes.fromMap(Map<String, dynamic> map) {
    return PaymentIntentAttributes(
      amount: map['amount'] ?? 0.0,
      paymentMethodAllowed:
          List<String>.from(map['payment_method_allowed'] ?? const []),
      options: PaymentIntentOptions.fromMap(map['payment_method_options']) ??
          PaymentIntentOptions(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentAttributes.fromJson(String source) =>
      PaymentIntentAttributes.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentIntentAttributes(amount: $amount, paymentMethodAllowed: $paymentMethodAllowed, options: $options)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentIntentAttributes &&
        other.amount == amount &&
        listEquals(other.paymentMethodAllowed, paymentMethodAllowed) &&
        other.options == options;
  }

  @override
  int get hashCode =>
      amount.hashCode ^ paymentMethodAllowed.hashCode ^ options.hashCode;
}

class PaymentIntentOptions {
  final PaymentIntentCard card;
  final String description;
  final String statementDescriptor;
  final String currency;
  final Map<String, dynamic> metadata;
  PaymentIntentOptions({
    this.card,
    this.description,
    this.statementDescriptor,
    this.currency,
    this.metadata,
  });

  PaymentIntentOptions copyWith({
    PaymentIntentCard card,
    String description,
    String statementDescriptor,
    String currency,
    Map<String, dynamic> metadata,
  }) {
    return PaymentIntentOptions(
      card: card ?? this.card,
      description: description ?? this.description,
      statementDescriptor: statementDescriptor ?? this.statementDescriptor,
      currency: currency ?? this.currency,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'card': card.toMap(),
      'description': description,
      'statement_descriptor': statementDescriptor,
      'currency': currency ?? 'PHP',
      'metadata': metadata,
    };
  }

  factory PaymentIntentOptions.fromMap(Map<String, dynamic> map) {
    return PaymentIntentOptions(
      card: PaymentIntentCard.fromMap(map['card']) ?? PaymentIntentCard(),
      description: map['description'] ?? '',
      statementDescriptor: map['statement_descriptor'] ?? '',
      currency: map['currency'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentOptions.fromJson(String source) =>
      PaymentIntentOptions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentIntentOptions(card: $card, description: $description, statementDescriptor: $statementDescriptor, currency: $currency, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentIntentOptions &&
        other.card == card &&
        other.description == description &&
        other.statementDescriptor == statementDescriptor &&
        other.currency == currency &&
        mapEquals(other.metadata, metadata);
  }

  @override
  int get hashCode {
    return card.hashCode ^
        description.hashCode ^
        statementDescriptor.hashCode ^
        currency.hashCode ^
        metadata.hashCode;
  }
}

class PaymentIntentCard {
  final String requestThreedSecure;
  PaymentIntentCard({
    this.requestThreedSecure,
  });

  PaymentIntentCard copyWith({
    String requestThreedSecure,
  }) {
    return PaymentIntentCard(
      requestThreedSecure: requestThreedSecure ?? this.requestThreedSecure,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'request_three_d_secure': requestThreedSecure ?? 'any',
    };
  }

  factory PaymentIntentCard.fromMap(Map<String, dynamic> map) {
    return PaymentIntentCard(
      requestThreedSecure: map['request_three_d_secure'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentCard.fromJson(String source) =>
      PaymentIntentCard.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentIntentCard(requestThreedSecure: $requestThreedSecure)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentIntentCard &&
        other.requestThreedSecure == requestThreedSecure;
  }

  @override
  int get hashCode => requestThreedSecure.hashCode;
}
