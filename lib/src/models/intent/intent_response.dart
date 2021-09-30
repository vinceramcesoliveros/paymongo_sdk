import 'dart:convert';

import 'package:equatable/equatable.dart';

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
  final String lastPaymentError;
  final List<String> paymentMethodAllowed;
  final List<String> payments;
  final String nextAction;
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
    required this.nextAction,
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
    String? nextAction,
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
      'statementDescriptor': statementDescriptor,
      'status': status,
      'livemode': livemode,
      'clientKey': clientKey,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'lastPaymentError': lastPaymentError,
      'paymentMethodAllowed': paymentMethodAllowed,
      'payments': payments,
      'nextAction': nextAction,
      'paymentMethodOptions': paymentMethodOptions.toMap(),
      'metadata': metadata,
    };
  }

  factory PaymentIntentResponseAttributes.fromMap(Map<String, dynamic> map) {
    return PaymentIntentResponseAttributes(
      amount: map['amount'] ?? 0,
      currency: map['currency'] ?? '',
      description: map['description'] ?? '',
      statementDescriptor: map['statementDescriptor'] ?? '',
      status: map['status'] ?? '',
      livemode: map['livemode'] ?? false,
      clientKey: map['clientKey'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      lastPaymentError: map['lastPaymentError'] ?? '',
      paymentMethodAllowed:
          List<String>.from(map['paymentMethodAllowed'] ?? const []),
      payments: List<String>.from(map['payments'] ?? const []),
      nextAction: map['nextAction'] ?? '',
      paymentMethodOptions:
          PaymentMethodOptions.fromMap(map['paymentMethodOptions']),
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentResponseAttributes.fromJson(String source) =>
      PaymentIntentResponseAttributes.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
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
    required this.card,
  });

  ///```json
  /// "card": {
  ///   "request_three_d_secure": "any"
  /// }
  ///```
  final Map<String, dynamic> card;
  @override
  List<Object> get props => [card];

  Map<String, dynamic> toMap() {
    return {
      'card': card,
    };
  }

  factory PaymentMethodOptions.fromMap(Map<String, dynamic> map) {
    return PaymentMethodOptions(
      card: Map<String, dynamic>.from(map['card'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethodOptions.fromJson(String source) =>
      PaymentMethodOptions.fromMap(json.decode(source));

  PaymentMethodOptions copyWith({
    Map<String, dynamic>? card,
  }) {
    return PaymentMethodOptions(
      card: card ?? this.card,
    );
  }
}
