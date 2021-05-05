import 'dart:convert';

class PayMongoAddress {
  final String city;
  final String country;
  final String line1;
  final String line2;
  final String postalCode;
  final String state;
  PayMongoAddress({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  PayMongoAddress copyWith({
    String city,
    String country,
    String line1,
    String line2,
    String postalCode,
    String state,
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

  String toJson() => json.encode(toMap());

  factory PayMongoAddress.fromJson(String source) =>
      PayMongoAddress.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayMongoAddress(city: $city, country: $country, line1: $line1, line2: $line2, postalCode: $postalCode, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PayMongoAddress &&
        other.city == city &&
        other.country == country &&
        other.line1 == line1 &&
        other.line2 == line2 &&
        other.postalCode == postalCode &&
        other.state == state;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        country.hashCode ^
        line1.hashCode ^
        line2.hashCode ^
        postalCode.hashCode ^
        state.hashCode;
  }
}
