import 'dart:convert';

import 'package:paymongo_sdk/paymongo_sdk.dart';

class PaymentAttributes {
  final double amount;
  final String? description;
  final String currency;
  final String? statementDescriptor;
  final PaymentSource source;
  const PaymentAttributes({
    required this.amount,
    this.description,
    required this.currency,
    this.statementDescriptor,
    required this.source,
  });

  PaymentAttributes copyWith({
    double? amount,
    String? description,
    String? currency,
    String? statementDescriptor,
    PaymentSource? source,
  }) {
    return PaymentAttributes(
      amount: amount ?? this.amount,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      statementDescriptor: statementDescriptor ?? this.statementDescriptor,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount.toCurrency(),
      'description': description,
      'currency': currency,
      'statement_descriptor': statementDescriptor,
      'source': source.toMap(),
    };
  }

  factory PaymentAttributes.fromMap(Map<String, dynamic> map) {
    return PaymentAttributes(
      amount: map['amount'] ?? 0.0,
      description: map['description'] ?? '',
      currency: map['currency'] ?? '',
      statementDescriptor: map['statementDescriptor'] ?? '',
      source: PaymentSource.fromMap(map['source']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentAttributes.fromJson(String source) =>
      PaymentAttributes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentAttributes(amount: $amount, description: $description, currency: $currency, statementDescriptor: $statementDescriptor, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentAttributes &&
        other.amount == amount &&
        other.description == description &&
        other.currency == currency &&
        other.statementDescriptor == statementDescriptor &&
        other.source == source;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        description.hashCode ^
        currency.hashCode ^
        statementDescriptor.hashCode ^
        source.hashCode;
  }
}

class PaymentSource {
  final String id;
  final String type;
  const PaymentSource({
    required this.id,
    required this.type,
  });

  PaymentSource copyWith({
    String? id,
    String? type,
  }) {
    return PaymentSource(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
    };
  }

  factory PaymentSource.fromMap(Map<String, dynamic> map) {
    return PaymentSource(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentSource.fromJson(String source) =>
      PaymentSource.fromMap(json.decode(source));

  @override
  String toString() => 'PaymentSource(id: $id, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentSource && other.id == id && other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}
