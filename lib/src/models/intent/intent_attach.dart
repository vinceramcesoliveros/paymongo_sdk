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

class PaymentIntentAttachResponse extends Equatable {
  final String id;
  final String type;
  final PaymentIntentAttachResponseAttributes attributes;
  const PaymentIntentAttachResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  factory PaymentIntentAttachResponse.fromMap(Map<String, dynamic> map) {
    return PaymentIntentAttachResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes:
          PaymentIntentAttachResponseAttributes.fromMap(map['attributes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentAttachResponse.fromJson(String source) =>
      PaymentIntentAttachResponse.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, type, attributes];
}

class PaymentIntentNextAction extends Equatable {
  final String type;
  final Redirect? redirect;
  const PaymentIntentNextAction({
    required this.type,
    required this.redirect,
  });

  PaymentIntentNextAction copyWith({
    String? type,
    Redirect? redirect,
  }) {
    return PaymentIntentNextAction(
      type: type ?? this.type,
      redirect: redirect ?? this.redirect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'redirect': redirect?.toMap(),
    };
  }

  factory PaymentIntentNextAction.fromMap(Map<String, dynamic> map) {
    return PaymentIntentNextAction(
      type: map['type'] ?? '',
      redirect: Redirect.fromMap(map['redirect']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentNextAction.fromJson(String source) =>
      PaymentIntentNextAction.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [type, redirect];
}

class PaymentIntentAttachResponseAttributes extends Equatable {
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
  final List<PaymentAttributesResponse> payments;
  final PaymentIntentNextAction? nextAction;
  final PaymentMethodOptions paymentMethodOptions;
  final Map<String, dynamic>? metadata;
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
    List<PaymentAttributesResponse>? payments,
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

  factory PaymentIntentAttachResponseAttributes.fromMap(
      Map<String, dynamic> map) {
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
      payments: List<PaymentAttributesResponse>.from(
          map['payments']?.map((x) => PaymentAttributesResponse.fromMap(x)) ??
              const []),
      nextAction: PaymentIntentNextAction.fromMap(map['next_action']),
      paymentMethodOptions: map['payment_method_options'] != null
          ? PaymentMethodOptions.fromMap(map['payment_method_options'])
          : const PaymentMethodOptions(),
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentAttachResponseAttributes.fromJson(String source) =>
      PaymentIntentAttachResponseAttributes.fromMap(json.decode(source));

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
