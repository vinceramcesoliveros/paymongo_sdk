import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

class LinkResponse extends Equatable {
  final String? id;
  final String? type;
  final LinkResponseAttributes? attributes;
  const LinkResponse({
    this.id,
    this.type,
    this.attributes,
  });

  LinkResponse copyWith({
    String? id,
    String? type,
    LinkResponseAttributes? attributes,
  }) {
    return LinkResponse(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes?.toMap(),
    };
  }

  factory LinkResponse.fromMap(Map<String, dynamic> map) {
    return LinkResponse(
      id: map['id'],
      type: map['type'],
      attributes: map['attributes'] != null
          ? LinkResponseAttributes.fromMap(map['attributes'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkResponse.fromJson(String source) =>
      LinkResponse.fromMap(json.decode(source));

  @override
  List<Object?> get props => [id, type, attributes];
}

class LinkResponseAttributes extends Equatable {
  final int? amount;
  final bool? archived;
  final String? currency;
  final String? description;
  final bool? livemode;
  final int? fee;
  final String? status;
  final int? taxAmount;
  final List<PaymentTaxResponse?> taxes;
  final String? checkoutUrl;
  final String? referenceNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PaymentListAllResponse> payments;
  const LinkResponseAttributes({
    this.amount,
    this.archived,
    this.currency,
    this.description,
    this.livemode,
    this.fee,
    this.status,
    this.taxAmount,
    required this.taxes,
    this.checkoutUrl,
    this.referenceNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.payments,
  });

  LinkResponseAttributes copyWith({
    int? amount,
    bool? archived,
    String? currency,
    String? description,
    bool? livemode,
    int? fee,
    String? status,
    int? taxAmount,
    List<PaymentTaxResponse?>? taxes,
    String? checkoutUrl,
    String? referenceNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<PaymentListAllResponse>? payments,
  }) {
    return LinkResponseAttributes(
      amount: amount ?? this.amount,
      archived: archived ?? this.archived,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      livemode: livemode ?? this.livemode,
      fee: fee ?? this.fee,
      status: status ?? this.status,
      taxAmount: taxAmount ?? this.taxAmount,
      taxes: taxes ?? this.taxes,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      payments: payments ?? this.payments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'archived': archived,
      'currency': currency,
      'description': description,
      'livemode': livemode,
      'fee': fee,
      'status': status,
      'taxAmount': taxAmount,
      'taxes': taxes.map((x) => x?.toMap()).toList(),
      'checkoutUrl': checkoutUrl,
      'referenceNumber': referenceNumber,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'payments': payments.map((x) => x.toMap()).toList(),
    };
  }

  factory LinkResponseAttributes.fromMap(Map<String, dynamic> map) {
    return LinkResponseAttributes(
      amount: map['amount']?.toInt(),
      archived: map['archived'],
      currency: map['currency'],
      description: map['description'],
      livemode: map['livemode'],
      fee: map['fee']?.toInt(),
      status: map['status'],
      taxAmount: map['taxAmount']?.toInt(),
      taxes: List<PaymentTaxResponse?>.from(
        map['taxes']?.map((x) => PaymentTaxResponse.fromMap(x)) ?? const [],
      ),
      checkoutUrl: map['checkoutUrl'],
      referenceNumber: map['referenceNumber'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
      payments: List<PaymentListAllResponse>.from(
        map['payments']?.map((x) => PaymentListAllResponse.fromMap(x)) ??
            const [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkResponseAttributes.fromJson(String source) =>
      LinkResponseAttributes.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      amount,
      archived,
      currency,
      description,
      livemode,
      fee,
      status,
      taxAmount,
      taxes,
      checkoutUrl,
      referenceNumber,
      createdAt,
      updatedAt,
      payments,
    ];
  }
}
