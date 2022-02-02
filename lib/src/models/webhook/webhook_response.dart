import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// {@template webhook_response}
///  response from paymongo webhook API
/// {@endtemplate}
class WebhookResponse extends Equatable {
  /// {@macro webhook_response}
  const WebhookResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  /// {@macro webhook_response}
  factory WebhookResponse.fromMap(Map<String, dynamic> map) {
    return WebhookResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: WebhookResponseAttribute.fromMap(map['attributes']),
    );
  }

  /// {@macro webhook_response}
  factory WebhookResponse.fromJson(String source) =>
      WebhookResponse.fromMap(json.decode(source));

  ///
  final String id;

  ///
  final String type;

  ///
  final WebhookResponseAttribute attributes;

  @override
  List<Object> get props => [id, type, attributes];

  /// {@macro webhook_response}
  WebhookResponse copyWith({
    String? id,
    String? type,
    WebhookResponseAttribute? attributes,
  }) {
    return WebhookResponse(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  /// {@macro webhook_response}
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes.toMap(),
    };
  }

  ///
  String toJson() => json.encode(toMap());

  /// {@macro webhook_response}
}
