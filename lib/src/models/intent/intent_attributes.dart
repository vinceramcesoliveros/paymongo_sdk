import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// {@template payment_intent_attributes}
///
/// {@endtemplate}
class PaymentIntentAttributes extends Equatable {
  /// {@macro payment_intent_attributes}
  const PaymentIntentAttributes({
    required this.amount,
    this.paymentMethodAllowed = const ['cash'],
    required this.options,
  });

  /// {@macro payment_intent_attributes}
  factory PaymentIntentAttributes.fromMap(Map<String, dynamic> map) {
    return PaymentIntentAttributes(
      amount: map['amount'] ?? 0.0,
      paymentMethodAllowed:
          List<String>.from(map['payment_method_allowed'] ?? const []),
      options: PaymentIntentOptions.fromMap(map['payment_method_options']),
    );
  }

  /// {@macro payment_intent_attributes}
  factory PaymentIntentAttributes.fromJson(String source) =>
      PaymentIntentAttributes.fromMap(json.decode(source));

  ///
  final double amount;

  /// default value must be ['card']
  /// ```dart
  /// List<String> paymenthMethodAllowed = ['cash']
  /// ```
  final List<String> paymentMethodAllowed;

  ///
  final PaymentIntentOptions options;

  /// {@macro payment_intent_attributes}
  PaymentIntentAttributes copyWith({
    double? amount,
    List<String>? paymentMethodAllowed,
    PaymentIntentOptions? options,
  }) {
    return PaymentIntentAttributes(
      amount: amount ?? this.amount,
      paymentMethodAllowed: paymentMethodAllowed ?? this.paymentMethodAllowed,
      options: options ?? this.options,
    );
  }

  /// {@macro payment_intent_attributes}
  Map<String, dynamic> toMap() {
    return {
      'amount': amount.toCurrency(),
      'payment_method_allowed': paymentMethodAllowed,
      'payment_method_options': options.toMap(),
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [amount, paymentMethodAllowed, options];
}

/// {@template payment_intent_options}
/// {@endtemplate}
class PaymentIntentOptions {
  /// {@macro payment_intent_options}
  const PaymentIntentOptions({
    this.card,
    this.description,
    this.statementDescriptor,
    this.currency,
    this.metadata,
  });

  /// {@macro payment_intent_options}
  factory PaymentIntentOptions.fromMap(Map<String, dynamic> map) {
    return PaymentIntentOptions(
      card: PaymentIntentCard.fromMap(map['card']),
      description: map['description'] ?? '',
      statementDescriptor: map['statement_descriptor'] ?? '',
      currency: map['currency'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  /// {@macro payment_intent_options}
  factory PaymentIntentOptions.fromJson(String source) =>
      PaymentIntentOptions.fromMap(json.decode(source));

  ///
  final PaymentIntentCard? card;

  ///
  final String? description;

  ///
  final String? statementDescriptor;

  ///
  final String? currency;

  ///
  final Map<String, dynamic>? metadata;

  /// {@macro payment_intent_options}
  PaymentIntentOptions copyWith({
    PaymentIntentCard? card,
    String? description,
    String? statementDescriptor,
    String currency = 'PHP',
    Map<String, dynamic>? metadata,
  }) {
    return PaymentIntentOptions(
      card: card ?? this.card,
      description: description ?? this.description,
      statementDescriptor: statementDescriptor ?? this.statementDescriptor,
      currency: currency.isEmpty ? 'PHP' : currency,
      metadata: metadata ?? this.metadata,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'card': card?.toMap(),
      'description': description,
      'statement_descriptor': statementDescriptor,
      'currency': currency ?? 'PHP',
      'metadata': metadata,
    };
  }

  ///
  String toJson() => json.encode(toMap());

  /// {@macro payment_intent_options}
}

/// {@template payment_intent_card}
/// {@endtemplate}
class PaymentIntentCard extends Equatable {
  /// {macro payment_intent_card}
  const PaymentIntentCard({
    this.requestThreedSecure = 'any',
  });

  /// {@macro payment_intent_card}
  factory PaymentIntentCard.fromMap(Map<String, dynamic> map) {
    return PaymentIntentCard(
      requestThreedSecure: map['request_three_d_secure'] ?? '',
    );
  }

  /// {@macro payment_intent_card}
  factory PaymentIntentCard.fromJsson(String source) =>
      PaymentIntentCard.fromMap(json.decode(source));

  ///
  final String requestThreedSecure;

  /// {@macro payment_intent_card}
  PaymentIntentCard copyWith({
    String? requestThreedSecure,
  }) {
    return PaymentIntentCard(
      requestThreedSecure: requestThreedSecure ?? this.requestThreedSecure,
    );
  }

  /// {@macro payment_intent_card}
  Map<String, dynamic> toMap() {
    return {
      'request_three_d_secure': requestThreedSecure,
    };
  }

  ///
  String toJson() => json.encode(toMap());

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

  @override
  List<Object?> get props => [requestThreedSecure];
}
