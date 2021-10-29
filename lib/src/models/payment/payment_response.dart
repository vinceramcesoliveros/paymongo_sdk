import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

class PaymentAttributesResponse extends Equatable {
  final String? accessUrl;
  final int amount;
  final String balanceTransactionId;
  final PayMongoBilling billing;
  final String currency;
  final String description;
  final bool disputed;
  final String? externalReferenceNumber;
  final int fee;
  final int foreignFee;
  final bool livemode;
  final int netAmount;
  final String origin;
  final String paymentIntentId;
  final String payout;
  final PaymentAttributeSourceResponse source;
  final String statementDescriptor;
  final String status;
  final int? taxAmount;
  final List<dynamic>? refunds;
  final List<dynamic>? taxes;
  final DateTime availableAt;
  final DateTime createdAt;
  final DateTime paidAt;
  final DateTime updatedAt;
  const PaymentAttributesResponse({
    required this.accessUrl,
    required this.amount,
    required this.balanceTransactionId,
    required this.billing,
    required this.currency,
    required this.description,
    required this.disputed,
    this.externalReferenceNumber,
    required this.fee,
    required this.foreignFee,
    required this.livemode,
    required this.netAmount,
    required this.origin,
    required this.payout,
    required this.source,
    required this.statementDescriptor,
    required this.status,
    this.taxAmount,
    required this.refunds,
    required this.taxes,
    required this.availableAt,
    required this.createdAt,
    required this.paidAt,
    required this.updatedAt,
    required this.paymentIntentId,
  });

  PaymentAttributesResponse copyWith({
    String? accessUrl,
    int? amount,
    String? balanceTransactionId,
    PayMongoBilling? billing,
    String? currency,
    String? description,
    bool? disputed,
    String? externalReferenceNumber,
    int? fee,
    int? foreignFee,
    bool? livemode,
    int? netAmount,
    String? origin,
    String? paymentIntentId,
    String? payout,
    PaymentAttributeSourceResponse? source,
    String? statementDescriptor,
    String? status,
    int? taxAmount,
    List<Object>? refunds,
    List<Object>? taxes,
    DateTime? availableAt,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? updatedAt,
  }) {
    return PaymentAttributesResponse(
      accessUrl: accessUrl ?? this.accessUrl,
      amount: amount ?? this.amount,
      balanceTransactionId: balanceTransactionId ?? this.balanceTransactionId,
      billing: billing ?? this.billing,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      disputed: disputed ?? this.disputed,
      externalReferenceNumber:
          externalReferenceNumber ?? this.externalReferenceNumber,
      fee: fee ?? this.fee,
      foreignFee: foreignFee ?? this.foreignFee,
      livemode: livemode ?? this.livemode,
      netAmount: netAmount ?? this.netAmount,
      origin: origin ?? this.origin,
      paymentIntentId: paymentIntentId ?? this.paymentIntentId,
      payout: payout ?? this.payout,
      source: source ?? this.source,
      statementDescriptor: statementDescriptor ?? this.statementDescriptor,
      status: status ?? this.status,
      taxAmount: taxAmount ?? this.taxAmount,
      refunds: refunds ?? this.refunds,
      taxes: taxes ?? this.taxes,
      availableAt: availableAt ?? this.availableAt,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt ?? this.paidAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessUrl': accessUrl,
      'amount': amount,
      'balanceTransactionId': balanceTransactionId,
      'billing': billing.toMap(),
      'currency': currency,
      'description': description,
      'disputed': disputed,
      'externalReferenceNumber': externalReferenceNumber,
      'fee': fee,
      'foreignFee': foreignFee,
      'livemode': livemode,
      'netAmount': netAmount,
      'origin': origin,
      'paymentIntentId': paymentIntentId,
      'payout': payout,
      'source': source.toMap(),
      'statementDescriptor': statementDescriptor,
      'status': status,
      'taxAmount': taxAmount,
      'availableAt': availableAt.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'paidAt': paidAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory PaymentAttributesResponse.fromMap(Map<String, dynamic> map) {
    return PaymentAttributesResponse(
      accessUrl: map['accessUrl'],
      amount: map['amount'] ?? 0,
      balanceTransactionId: map['balanceTransactionId'] ?? '',
      billing: PayMongoBilling.fromMap(map['billing']),
      currency: map['currency'] ?? '',
      description: map['description'] ?? '',
      disputed: map['disputed'] ?? false,
      externalReferenceNumber: map['externalReferenceNumber'],
      fee: map['fee'] ?? 0,
      foreignFee: map['foreignFee'] ?? 0,
      livemode: map['livemode'] ?? false,
      netAmount: map['netAmount'] ?? 0,
      origin: map['origin'] ?? '',
      paymentIntentId: map['paymentIntentId'] ?? '',
      payout: map['payout'] ?? '',
      source: PaymentAttributeSourceResponse.fromMap(map['source']),
      statementDescriptor: map['statementDescriptor'] ?? '',
      status: map['status'] ?? '',
      taxAmount: map['taxAmount'],
      refunds: map['refunds'],
      taxes: map['taxes'],
      availableAt: DateTime.fromMillisecondsSinceEpoch(map['availableAt']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      paidAt: DateTime.fromMillisecondsSinceEpoch(map['paidAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentAttributesResponse.fromJson(String source) =>
      PaymentAttributesResponse.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      accessUrl,
      amount,
      balanceTransactionId,
      billing,
      currency,
      description,
      disputed,
      externalReferenceNumber,
      fee,
      foreignFee,
      livemode,
      netAmount,
      origin,
      payout,
      source,
      statementDescriptor,
      status,
      taxAmount,
      refunds,
      taxes,
      availableAt,
      createdAt,
      paidAt,
      updatedAt,
      paymentIntentId,
    ];
  }
}
