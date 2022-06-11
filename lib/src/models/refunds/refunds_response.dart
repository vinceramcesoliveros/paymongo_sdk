import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

class RefundResponse extends Equatable {
  const RefundResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory RefundResponse.fromMap(Map<String, dynamic> map) {
    return RefundResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: RefundResponseAttributes.fromMap(map['attributes']),
    );
  }

  factory RefundResponse.fromJson(String source) =>
      RefundResponse.fromMap(json.decode(source));

  final String id;
  final String type;
  final RefundResponseAttributes attributes;

  RefundResponse copyWith({
    String? id,
    String? type,
    RefundResponseAttributes? attributes,
  }) {
    return RefundResponse(
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

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RefundResponse(id: $id, type: $type, attributes: $attributes)';

  @override
  List<Object> get props => [id, type, attributes];
}

class RefundResponseAttributes extends Equatable {
  const RefundResponseAttributes({
    required this.amount,
    required this.currency,
    required this.livemode,
    this.notes,
    required this.paymentId,
    this.payoutId,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.balanceTransactionId,
  });

  factory RefundResponseAttributes.fromMap(Map<String, dynamic> map) {
    return RefundResponseAttributes(
      amount: map['amount']?.toInt() ?? 0,
      currency: map['currency'] ?? '',
      livemode: map['livemode'] ?? false,
      notes: map['notes'],
      paymentId: map['payment_id'] ?? '',
      payoutId: map['payout_id'],
      reason: map['reason'] ?? '',
      status: map['status'] ?? '',
      createdAt: fromTimeStamp(map['created_at']),
      updatedAt: fromTimeStamp(map['updated_at']),
      balanceTransactionId: map['balance_transaction_id'],
    );
  }

  factory RefundResponseAttributes.fromJson(String source) =>
      RefundResponseAttributes.fromMap(json.decode(source));

  final int amount;
  final String currency;
  final bool livemode;
  final String? notes;
  final String paymentId;
  final String? payoutId;
  final String reason;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? balanceTransactionId;
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
      'livemode': livemode,
      'notes': notes,
      'payment_id': paymentId,
      'payout_id': payoutId,
      'reason': reason,
      'status': status,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'balance_transaction_id': balanceTransactionId,
    };
  }

  String toJson() => json.encode(toMap());

  RefundResponseAttributes copyWith({
    int? amount,
    String? currency,
    bool? livemode,
    String? notes,
    String? paymentId,
    String? payoutId,
    String? reason,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? balanceTransactionId,
  }) {
    return RefundResponseAttributes(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      livemode: livemode ?? this.livemode,
      notes: notes ?? this.notes,
      paymentId: paymentId ?? this.paymentId,
      payoutId: payoutId ?? this.payoutId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      balanceTransactionId: balanceTransactionId ?? this.balanceTransactionId,
    );
  }

  @override
  List<Object?> get props {
    return [
      amount,
      currency,
      livemode,
      notes,
      paymentId,
      payoutId,
      reason,
      status,
      createdAt,
      updatedAt,
      balanceTransactionId,
    ];
  }
}
