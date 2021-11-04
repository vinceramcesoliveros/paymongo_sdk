import 'dart:convert';

import 'package:equatable/equatable.dart';

///
class Redirect extends Equatable {
  ///
  const Redirect({
    required this.success,
    required this.failed,
    this.checkoutUrl,
    this.url,
    this.returnUrl,
  });

  ///
  factory Redirect.fromMap(Map<String, dynamic> map) {
    return Redirect(
      success: map['success'] ?? '',
      failed: map['failed'] ?? '',
      checkoutUrl: map['checkout_url'],
      url: map['url'],
      returnUrl: map['return_url'],
    );
  }

  ///
  factory Redirect.fromJson(String source) =>
      Redirect.fromMap(json.decode(source));

  ///
  final String success;

  ///
  final String failed;

  ///
  final String? checkoutUrl;

  ///
  final String? url;

  ///
  final String? returnUrl;

  ///
  Redirect copyWith({
    String? success,
    String? failed,
    String? checkoutUrl,
    String? url,
    String? returnUrl,
  }) {
    return Redirect(
      success: success ?? this.success,
      failed: failed ?? this.failed,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      url: url ?? this.url,
      returnUrl: returnUrl ?? this.returnUrl,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'failed': failed,
      'checkout_url': checkoutUrl,
      'url': url,
      'return_url': returnUrl,
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      success,
      failed,
      checkoutUrl,
      url,
      returnUrl,
    ];
  }
}
