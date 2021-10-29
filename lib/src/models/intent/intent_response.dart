import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

class PaymentIntentResponse extends Equatable {
  final String id;
  final String type;
  final PaymentIntentResponseAttributes attributes;
  const PaymentIntentResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  PaymentIntentResponse copyWith({
    String? id,
    String? type,
    PaymentIntentResponseAttributes? attributes,
  }) {
    return PaymentIntentResponse(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  factory PaymentIntentResponse.fromMap(Map<String, dynamic> map) {
    return PaymentIntentResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: PaymentIntentResponseAttributes.fromMap(map['attributes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentResponse.fromJson(String source) =>
      PaymentIntentResponse.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, type, attributes];
}

class PaymentIntentResponseAttributes extends Equatable {
  final int amount;
  final String currency;
  final String description;
  final String statementDescriptor;
  final String status;
  final bool livemode;
  final String clientKey;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? lastPaymentError;
  final List<String> paymentMethodAllowed;
  final List<String> payments;
  final PaymentIntentNextAction? nextAction;
  final PaymentMethodOptions paymentMethodOptions;
  final Map<String, dynamic> metadata;
  const PaymentIntentResponseAttributes({
    required this.amount,
    required this.currency,
    required this.description,
    required this.statementDescriptor,
    required this.status,
    required this.livemode,
    required this.clientKey,
    required this.createdAt,
    required this.updatedAt,
    required this.lastPaymentError,
    required this.paymentMethodAllowed,
    required this.payments,
    this.nextAction,
    required this.paymentMethodOptions,
    required this.metadata,
  });

  PaymentIntentResponseAttributes copyWith({
    int? amount,
    String? currency,
    String? description,
    String? statementDescriptor,
    String? status,
    bool? livemode,
    String? clientKey,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? lastPaymentError,
    List<String>? paymentMethodAllowed,
    List<String>? payments,
    PaymentIntentNextAction? nextAction,
    PaymentMethodOptions? paymentMethodOptions,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentIntentResponseAttributes(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      statementDescriptor: statementDescriptor ?? this.statementDescriptor,
      status: status ?? this.status,
      livemode: livemode ?? this.livemode,
      clientKey: clientKey ?? this.clientKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastPaymentError: lastPaymentError ?? this.lastPaymentError,
      paymentMethodAllowed: paymentMethodAllowed ?? this.paymentMethodAllowed,
      payments: payments ?? this.payments,
      nextAction: nextAction ?? this.nextAction,
      paymentMethodOptions: paymentMethodOptions ?? this.paymentMethodOptions,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
      'description': description,
      'statement_descriptor': statementDescriptor,
      'status': status,
      'livemode': livemode,
      'client_key': clientKey,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'last_payment_error': lastPaymentError,
      'payment_method_allowed': paymentMethodAllowed,
      'payments': payments,
      'next_action': nextAction?.toMap(),
      'payment_method_options': paymentMethodOptions.toMap(),
      'metadata': metadata,
    };
  }

  factory PaymentIntentResponseAttributes.fromMap(Map<String, dynamic> map) {
    return PaymentIntentResponseAttributes(
      amount: map['amount'] ?? 0,
      currency: map['currency'] ?? '',
      description: map['description'] ?? '',
      statementDescriptor: map['statement_descriptor'] ?? '',
      status: map['status'] ?? '',
      livemode: map['livemode'] ?? false,
      clientKey: map['client_key'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      lastPaymentError: map['last_payment_error'] ?? '',
      paymentMethodAllowed:
          List<String>.from(map['payment_method_allowed'] ?? const []),
      payments: List<String>.from(map['payments'] ?? const []),
      nextAction: map['next_action'] != null
          ? PaymentIntentNextAction.fromMap(map['next_action'])
          : null,
      paymentMethodOptions:
          PaymentMethodOptions.fromMap(map['payment_method_options']),
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentResponseAttributes.fromJson(String source) =>
      PaymentIntentResponseAttributes.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      amount,
      currency,
      description,
      statementDescriptor,
      status,
      livemode,
      clientKey,
      createdAt,
      updatedAt,
      lastPaymentError,
      paymentMethodAllowed,
      payments,
      nextAction,
      paymentMethodOptions,
      metadata,
    ];
  }
}

class PaymentMethodOptions extends Equatable {
  const PaymentMethodOptions({
    this.card = const PaymentIntentCard(),
  });

  ///```json
  /// "card": {
  ///   "request_three_d_secure": "any"
  /// }
  ///```
  final PaymentIntentCard card;
  @override
  List<Object> get props => [card];

  Map<String, dynamic> toMap() {
    return {
      'card': card.toMap(),
    };
  }

  factory PaymentMethodOptions.fromMap(Map<String, dynamic> map) {
    return PaymentMethodOptions(
      card: map['card'] != null
          ? PaymentIntentCard.fromMap(map['card'])
          : const PaymentIntentCard(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodOptions.fromJson(String source) =>
      PaymentMethodOptions.fromMap(json.decode(source));

  PaymentMethodOptions copyWith({
    PaymentIntentCard? card,
  }) {
    return PaymentMethodOptions(
      card: card ?? this.card,
    );
  }

  @override
  bool get stringify => true;
}
