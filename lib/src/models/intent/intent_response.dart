import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// {@template payment_intent_response}
/// {@endtemplate}
class PaymentIntentResponse extends Equatable {
  /// {@macro payment_intent_response}
  const PaymentIntentResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  /// {@macro payment_intent_response}
  factory PaymentIntentResponse.fromMap(Map<String, dynamic> map) {
    return PaymentIntentResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: PaymentIntentResponseAttributes.fromMap(map['attributes']),
    );
  }

  /// {@macro payment_intent_response}
  factory PaymentIntentResponse.fromJson(String source) =>
      PaymentIntentResponse.fromMap(json.decode(source));

  ///
  final String id;

  ///
  final String type;

  ///
  final PaymentIntentResponseAttributes attributes;

  /// {@macro payment_intent_response}
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

  /// {@macro payment_intent_response}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  /// {@macro payment_intent_response}
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, type, attributes];
}

/// {@template payment_intent_response}
/// payment intent response
/// {@endtemplate}
class PaymentsIntentResponse extends Equatable {
  ///{@macro payment_intent_response}
  const PaymentsIntentResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  ///{@macro payment_intent_response}
  factory PaymentsIntentResponse.fromMap(Map<String, dynamic> map) {
    return PaymentsIntentResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: CreatePaymentResponse.fromMap(map['attributes']),
    );
  }

  ///{@macro payment_intent_response}
  factory PaymentsIntentResponse.fromJson(String source) =>
      PaymentsIntentResponse.fromMap(json.decode(source));

  ///
  final String id;

  ///
  final String type;

  ///
  final CreatePaymentResponse attributes;

  @override
  List<Object?> get props => [id, type, attributes];

  ///{@macro payment_intent_response}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  ///{@macro payment_intent_response}
  String toJson() => json.encode(toMap());
}

///{@template payment_intent_response_attributes}
///{@endtemplate}
class PaymentIntentResponseAttributes extends Equatable {
  ///{@macro payment_intent_response_attributes}
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

  ///{@macro payment_intent_response_attributes}
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
      payments: List<PaymentsIntentResponse>.from(
        map['payments']?.map((x) => PaymentsIntentResponse.fromMap(x)) ??
            const [],
      ),
      nextAction: map['next_action'] != null
          ? PaymentIntentNextAction.fromMap(map['next_action'])
          : null,
      paymentMethodOptions:
          PaymentMethodOptions.fromMap(map['payment_method_options']),
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  ///{@macro payment_intent_response_attributes}
  factory PaymentIntentResponseAttributes.fromJson(String source) =>
      PaymentIntentResponseAttributes.fromMap(json.decode(source));

  ///
  final int amount;

  ///
  final String currency;

  ///
  final String description;

  ///
  final String statementDescriptor;

  ///
  final String status;

  ///
  final bool livemode;

  ///
  final String clientKey;

  ///
  final DateTime createdAt;

  ///
  final DateTime updatedAt;

  ///
  final String? lastPaymentError;

  ///
  final List<String> paymentMethodAllowed;

  ///
  final List<PaymentsIntentResponse> payments;

  ///
  final PaymentIntentNextAction? nextAction;

  ///
  final PaymentMethodOptions paymentMethodOptions;

  ///
  final Map<String, dynamic> metadata;

  ///{@macro payment_intent_response_attributes}
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
    List<PaymentsIntentResponse>? payments,
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

  ///{@macro payment_intent_response_attributes}
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

  ///{@macro payment_intent_response_attributes}
  String toJson() => json.encode(toMap());

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

/// {@template payment_method_options}
/// properties are initialized by default.
/// {@endtemplate}
class PaymentMethodOptions extends Equatable {
  /// {@macro payment_method_options}
  const PaymentMethodOptions({
    this.card = const PaymentIntentCard(),
  });

  /// {@macro payment_method_options}
  factory PaymentMethodOptions.fromMap(Map<String, dynamic> map) {
    return PaymentMethodOptions(
      card: map['card'] != null
          ? PaymentIntentCard.fromMap(map['card'])
          : const PaymentIntentCard(),
    );
  }

  /// {@macro payment_method_options}
  factory PaymentMethodOptions.fromJson(String source) =>
      PaymentMethodOptions.fromMap(json.decode(source));

  /// {@macro payment_method_options}
  PaymentMethodOptions copyWith({
    PaymentIntentCard? card,
  }) {
    return PaymentMethodOptions(
      card: card ?? this.card,
    );
  }

  ///```json
  /// "card": {
  ///   "request_three_d_secure": "any"
  /// }
  ///```
  final PaymentIntentCard card;
  @override
  List<Object> get props => [card];

  /// {@macro payment_method_options}
  Map<String, dynamic> toMap() {
    return {
      'card': card.toMap(),
    };
  }

  /// {@macro payment_method_options}
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
