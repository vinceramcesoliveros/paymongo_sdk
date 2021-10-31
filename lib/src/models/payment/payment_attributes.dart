import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// {@template create_payment_attr}
/// https://developers.paymongo.com/reference/create-a-payment
/// {@endtemplate}
class CreatePaymentAttributes extends Equatable {
  ///{@macro create_payment_attr}
  const CreatePaymentAttributes({
    required this.amount,
    this.description,
    required this.currency,
    this.statementDescriptor,
    required this.source,
  });

  ///{@macro create_payment_attr}
  factory CreatePaymentAttributes.fromMap(Map<String, dynamic> map) {
    return CreatePaymentAttributes(
      amount: map['amount'] ?? 0.0,
      description: map['description'] ?? '',
      currency: map['currency'] ?? '',
      statementDescriptor: map['statementDescriptor'] ?? '',
      source: PaymentSource.fromMap(map['source']),
    );
  }

  ///{@macro create_payment_attr}
  factory CreatePaymentAttributes.fromJson(String source) =>
      CreatePaymentAttributes.fromMap(json.decode(source));

  /// the package handles converting the amount * 100
  final double amount;

  /// description can be viewed on the paymongo dashboard
  final String? description;

  /// defaults to PHP
  final String currency;

  ///
  final String? statementDescriptor;

  ///
  final PaymentSource source;

  ///{@macro create_payment_attr}
  CreatePaymentAttributes copyWith({
    double? amount,
    String? description,
    String? currency,
    String? statementDescriptor,
    PaymentSource? source,
  }) {
    return CreatePaymentAttributes(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      statementDescriptor: statementDescriptor ?? this.statementDescriptor,
      source: source ?? this.source,
    );
  }

  ///{@macro create_payment_attr}
  Map<String, dynamic> toMap() {
    return {
      'amount': amount.toCurrency(),
      'description': description,
      'currency': currency,
      'statement_descriptor': statementDescriptor,
      'source': source.toMap(),
    };
  }

  ///{@macro create_payment_attr}
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      amount,
      description,
      currency,
      statementDescriptor,
      source,
    ];
  }
}

/// {@template payment_source}
/// {@endtemplate}
class PaymentSource extends Equatable {
  ///{@macro payment_source}
  const PaymentSource({
    required this.id,
    required this.type,
  });

  ///{@macro payment_source}
  factory PaymentSource.fromMap(Map<String, dynamic> map) {
    return PaymentSource(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
    );
  }

  ///{@macro payment_source}
  factory PaymentSource.fromJson(String source) =>
      PaymentSource.fromMap(json.decode(source));

  ///
  final String id;

  ///
  final String type;

  ///{@macro payment_source}
  PaymentSource copyWith({
    String? id,
    String? type,
  }) {
    return PaymentSource(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  ///{@macro payment_source}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
    };
  }

  ///{@macro payment_source}
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [id, type];
}
