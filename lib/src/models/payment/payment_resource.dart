import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// {@template create_payment_response}
class CreatePaymentResponse extends Equatable {
  /// {@template create_payment_response}
  const CreatePaymentResponse({
    this.id,
    this.source,
    this.type,
  });

  /// {@template create_payment_response}
  factory CreatePaymentResponse.fromMap(Map<String, dynamic> map) {
    return CreatePaymentResponse(
      id: map['id'],
      source:
          map['source'] != null ? SourceResult.fromMap(map['source']) : null,
      type: map['type'],
    );
  }

  /// {@template create_payment_response}
  factory CreatePaymentResponse.fromJson(String source) =>
      CreatePaymentResponse.fromMap(json.decode(source));

  ///
  final String? id;

  ///
  final SourceResult? source;

  ///
  final String? type;

  /// {@template create_payment_response}

  CreatePaymentResponse copyWith({
    String? id,
    SourceResult? source,
    String? type,
  }) {
    return CreatePaymentResponse(
      id: id ?? this.id,
      source: source ?? this.source,
      type: type ?? this.type,
    );
  }

  /// {@template create_payment_response}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source?.toMap(),
      'type': type,
    };
  }

  /// {@template create_payment_response}
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [id, source, type];
}
