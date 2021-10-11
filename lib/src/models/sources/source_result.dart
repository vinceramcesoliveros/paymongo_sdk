import 'dart:convert';

import 'package:paymongo_sdk/paymongo_sdk.dart';

class SourceResult {
  final String? id;
  final String? type;
  final Source? attributes;
  const SourceResult({
    this.id,
    this.type,
    this.attributes,
  });

  SourceResult copyWith({
    String? id,
    String? type,
    Source? attributes,
  }) {
    return SourceResult(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes!.toMap(),
    };
  }

  factory SourceResult.fromMap(Map<String, dynamic> map) {
    return SourceResult(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: Source.fromMap(map['attributes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SourceResult.fromJson(String source) =>
      SourceResult.fromMap(json.decode(source));

  @override
  String toString() =>
      'SourceResult(id: $id, type: $type, attributes: $attributes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SourceResult &&
        other.id == id &&
        other.type == type &&
        other.attributes == attributes;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ attributes.hashCode;
}
