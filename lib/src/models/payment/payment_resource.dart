import 'dart:convert';

class PaymentResource {
  final String? id;
  final String? source;
  final String? type;
  const PaymentResource({
    this.id,
    this.source,
    this.type,
  });

  PaymentResource copyWith({
    String? id,
    String? source,
    String? type,
  }) {
    return PaymentResource(
      id: id ?? this.id,
      source: source ?? this.source,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'type': type,
    };
  }

  factory PaymentResource.fromMap(Map<String, dynamic> map) {
    return PaymentResource(
      id: map['id'],
      source: map['source'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentResource.fromJson(String source) =>
      PaymentResource.fromMap(json.decode(source));

  @override
  String toString() => 'PaymentResource(id: $id, source: $source, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentResource &&
        other.id == id &&
        other.source == source &&
        other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ source.hashCode ^ type.hashCode;
}
