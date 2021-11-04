import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

///
class SourceResult extends Equatable {
  ///
  const SourceResult({
    this.id,
    this.type,
    this.attributes,
  });

  ///

  factory SourceResult.fromMap(Map<String, dynamic> map) {
    return SourceResult(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      attributes: map['attributes'] != null
          ? SourceAttributes.fromMap(map['attributes'])
          : null,
    );
  }

  ///
  factory SourceResult.fromJson(String source) =>
      SourceResult.fromMap(json.decode(source));

  ///
  final String? id;

  ///
  final String? type;

  ///
  final SourceAttributes? attributes;

  ///
  SourceResult copyWith({
    String? id,
    String? type,
    SourceAttributes? attributes,
  }) {
    return SourceResult(
      id: id ?? this.id,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'attributes': attributes!.toMap(),
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [id, type, attributes];
}
