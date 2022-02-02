import 'dart:convert';

import 'package:equatable/equatable.dart';

/// {@template webhook_response_attribute}
///  response attribute from the receiving API
/// {@endtemplate}
class WebhookResponseAttribute extends Equatable {
  /// {@macro webhook_response_attribute}
  const WebhookResponseAttribute({
    required this.livemode,
    required this.secretKey,
    required this.status,
    required this.url,
    required this.events,
    required this.createdAt,
    required this.updatedAt,
  });

  /// {@macro webhook_response_attribute}
  factory WebhookResponseAttribute.fromMap(Map<String, dynamic> map) {
    return WebhookResponseAttribute(
      livemode: map['livemode'] ?? false,
      secretKey: map['secretKey'] ?? '',
      status: map['status'] ?? '',
      url: map['url'] ?? '',
      events: List<String>.from(map['events'] ?? const []),
      createdAt: map['createdAt']?.toInt() ?? 0,
      updatedAt: map['updatedAt']?.toInt() ?? 0,
    );
  }

  /// {@macro webhook_response_attribute}
  factory WebhookResponseAttribute.fromJson(String source) =>
      WebhookResponseAttribute.fromMap(json.decode(source));

  ///
  final bool livemode;

  ///
  final String secretKey;

  ///
  final String status;

  ///
  final String url;

  ///
  final List<String> events;

  ///
  final int createdAt;

  ///
  final int updatedAt;

  /// {@macro webhook_response_attribute}
  Map<String, dynamic> toMap() {
    return {
      'livemode': livemode,
      'secretKey': secretKey,
      'status': status,
      'url': url,
      'events': events,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// {@macro webhook_response_attribute}
  String toJson() => json.encode(toMap());

  /// {@macro webhook_response_attribute}
  WebhookResponseAttribute copyWith({
    bool? livemode,
    String? secretKey,
    String? status,
    String? url,
    List<String>? events,
    int? createdAt,
    int? updatedAt,
  }) {
    return WebhookResponseAttribute(
      livemode: livemode ?? this.livemode,
      secretKey: secretKey ?? this.secretKey,
      status: status ?? this.status,
      url: url ?? this.url,
      events: events ?? this.events,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object> get props {
    return [
      livemode,
      secretKey,
      status,
      url,
      events,
      createdAt,
      updatedAt,
    ];
  }
}
