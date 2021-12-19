import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

///{@template payment_intent_attach}
/// Use to attach Payment Intent and returns a [PaymentIntentAttachResponse]
/// object
///
/// https://developers.paymongo.com/docs/accepting-cards#3-send-card-information-to-paymongo
///{@endtemplate}
class PaymentIntentAttach extends Equatable {
  /// {@macro payment_intent_attach}
  const PaymentIntentAttach({
    required this.paymentMethod,
    this.clientKey,
    this.returnUrl,
  });

  /// Converts [Map<String,dynamic>] to [PaymentIntentAttach] class
  /// {@macro payment_intent_attach}
  factory PaymentIntentAttach.fromMap(Map<String, dynamic> map) {
    return PaymentIntentAttach(
      paymentMethod: map['payment_method'] ?? '',
      clientKey: map['client_key'] ?? '',
      returnUrl: map['return_url'] ?? '',
    );
  }

  /// Converts [String] of json to [PaymentIntentAttach] class
  /// {@macro payment_intent_attach}
  factory PaymentIntentAttach.fromJson(String source) =>
      PaymentIntentAttach.fromMap(json.decode(source));

  /// id of PaymentMethod to attach to the PaymentIntent
  final String paymentMethod;

  /// From [PaymentIntentResponse] client key if the key used is
  /// a public API key
  final String? clientKey;

  /// An optional value for card payment method but required for paymaya.
  /// The URL to redirect your customer back to after they authenticate
  /// or cancel their payment. This parameter is only used for redirect-based
  /// payment methods.
  final String? returnUrl;

  /// {@macro payment_intent_attach}
  PaymentIntentAttach copyWith({
    String? paymentMethod,
    String? clientKey,
    String? returnUrl,
  }) {
    return PaymentIntentAttach(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      clientKey: clientKey ?? this.clientKey,
      returnUrl: returnUrl ?? this.returnUrl,
    );
  }

  /// Converts [PaymentIntentAttach] to [Map<String,dynamic>]
  ///
  /// {@macro payment_intent_attach}
  Map<String, dynamic> toMap() {
    return {
      'payment_method': paymentMethod,
      'client_key': clientKey,
      'return_url': returnUrl,
    };
  }

  /// Converts [Map<String,dynamic>] to [String] json
  String toJson() => json.encode(toMap());

  @override
  String toString() => '''
      PaymentIntentAttach(paymentMethod: $paymentMethod, 
      clientKey: $clientKey, 
      returnUrl: $returnUrl
      )
      ''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentIntentAttach &&
        other.paymentMethod == paymentMethod &&
        other.clientKey == clientKey &&
        other.returnUrl == returnUrl;
  }

  @override
  int get hashCode =>
      paymentMethod.hashCode ^ clientKey.hashCode ^ returnUrl.hashCode;

  @override
  List<Object?> get props => [paymentMethod, clientKey, returnUrl];
}

/// {@template payment_intent_attach_response}
/// Returns a resposne when you attach a payment intent.
/// {@endtemplate}
class PaymentIntentAttachResponse extends Equatable {
  /// {@macro payment_intent_attach_response}
  const PaymentIntentAttachResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  /// {@macro payment_intent_attach_response}
  factory PaymentIntentAttachResponse.fromMap(Map<String, dynamic> map) {
    return PaymentIntentAttachResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes:
          PaymentIntentAttachResponseAttributes.fromMap(map['attributes']),
    );
  }

  /// {@macro payment_intent_attach_response}
  factory PaymentIntentAttachResponse.fromJson(String source) =>
      PaymentIntentAttachResponse.fromMap(json.decode(source));

  /// payment intent id
  final String id;

  /// payment intent type
  final String type;

  /// response from creating payment intent  api
  final PaymentIntentAttachResponseAttributes attributes;

  /// {@macro payment_intent_attach_response}
  PaymentIntentAttachResponse copyWith({
    String? id,
    String? type,
    PaymentIntentAttachResponseAttributes? attributes,
  }) {
    return PaymentIntentAttachResponse(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  /// {@macro payment_intent_attach_response}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  /// {@macro payment_intent_attach_response}
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, type, attributes];
}

/// {@template payment_intent_next_action}
/// recommend you follow the next action type from the documentation.
/// {@endtemplate}
class PaymentIntentNextAction extends Equatable {
  /// {@macro payment_intent_next_action}
  const PaymentIntentNextAction({
    required this.type,
    required this.redirect,
  });

  /// {@macro payment_intent_next_action}
  factory PaymentIntentNextAction.fromMap(Map<String, dynamic> map) {
    return PaymentIntentNextAction(
      type: map['type'] ?? '',
      redirect: Redirect.fromMap(map['redirect']),
    );
  }

  /// {@macro payment_intent_next_action}
  factory PaymentIntentNextAction.fromJson(String source) =>
      PaymentIntentNextAction.fromMap(json.decode(source));

  /// next action type
  final String type;

  /// this is accessible when 3DS is detected.
  final Redirect? redirect;

  /// {@macro payment_intent_next_action}
  PaymentIntentNextAction copyWith({
    String? type,
    Redirect? redirect,
  }) {
    return PaymentIntentNextAction(
      type: type ?? this.type,
      redirect: redirect ?? this.redirect,
    );
  }

  /// {@macro payment_intent_next_action}
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'redirect': redirect?.toMap(),
    };
  }

  /// {@macro payment_intent_next_action}
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [type, redirect];
}

/// {@template payment_intent_attach_response_attributes}
/// Response from payment intent attach
/// {@endtemplate}
class PaymentIntentAttachResponseAttributes extends Equatable {
  /// {@macro payment_intent_attach_response_attributes}
  const PaymentIntentAttachResponseAttributes({
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
    required this.paymentMethodOptions,
    this.nextAction,
    this.metadata,
  });

  /// {@macro payment_intent_attach_response_attributes}
  factory PaymentIntentAttachResponseAttributes.fromJson(String source) =>
      PaymentIntentAttachResponseAttributes.fromMap(json.decode(source));

  /// {@macro payment_intent_attach_response_attributes}
  factory PaymentIntentAttachResponseAttributes.fromMap(
    Map<String, dynamic> map,
  ) {
    return PaymentIntentAttachResponseAttributes(
      amount: map['amount'],
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
      payments: List<CreatePaymentResponse>.from(
        map['payments']?.map((x) => CreatePaymentResponse.fromMap(x)) ??
            const [],
      ),
      nextAction: map['next_action'] != null
          ? PaymentIntentNextAction.fromMap(map['next_action'])
          : null,
      paymentMethodOptions: map['payment_method_options'] != null
          ? PaymentMethodOptions.fromMap(map['payment_method_options'])
          : const PaymentMethodOptions(),
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

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
  final String lastPaymentError;

  ///
  final List<String> paymentMethodAllowed;

  ///
  final List<CreatePaymentResponse> payments;

  ///
  final PaymentIntentNextAction? nextAction;

  ///
  final PaymentMethodOptions paymentMethodOptions;

  ///
  final Map<String, dynamic>? metadata;

  /// {@macro payment_intent_attach_response_attributes}
  PaymentIntentAttachResponseAttributes copyWith({
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
    List<CreatePaymentResponse>? payments,
    PaymentIntentNextAction? nextAction,
    PaymentMethodOptions? paymentMethodOptions,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentIntentAttachResponseAttributes(
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

  /// {@macro payment_intent_attach_response_attributes}
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
      'payments': payments.map((x) => x.toMap()).toList(),
      'next_action': nextAction?.toMap(),
      'payment_method_options': paymentMethodOptions.toMap(),
      'metadata': metadata,
    };
  }

  /// {@macro payment_intent_attach_response_attributes}
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
