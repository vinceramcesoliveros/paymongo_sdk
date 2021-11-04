import 'dart:convert';

/// {@template customer_address}
///
/// customer address
/// {@endtemplate}
class PayMongoAddress {
  /// {@macro customer_address}
  const PayMongoAddress({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  /// {@macro customer_address}
  factory PayMongoAddress.fromMap(Map<String, dynamic> map) {
    return PayMongoAddress(
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      line1: map['line1'] ?? '',
      line2: map['line2'] ?? '',
      postalCode: map['postal_code'] ?? '',
      state: map['state'] ?? '',
    );
  }

  /// {@macro customer_address}
  factory PayMongoAddress.fromJson(String source) =>
      PayMongoAddress.fromMap(json.decode(source));

  ///
  final String? city;

  ///
  final String? country;

  ///
  final String? line1;

  ///
  final String? line2;

  ///
  final String? postalCode;

  ///
  final String? state;

  /// {@macro customer_address}
  PayMongoAddress copyWith({
    String? city,
    String? country,
    String? line1,
    String? line2,
    String? postalCode,
    String? state,
  }) {
    return PayMongoAddress(
      city: city ?? this.city,
      country: country ?? this.country,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      postalCode: postalCode ?? this.postalCode,
      state: state ?? this.state,
    );
  }

  /// {@macro customer_address}
  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'country': country,
      'line1': line1,
      'line2': line2,
      'postal_code': postalCode,
      'state': state,
    };
  }

  /// {@macro customer_address}
  String toJson() => json.encode(toMap());
}
