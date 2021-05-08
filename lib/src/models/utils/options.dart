import 'dart:convert';

import 'package:flutter/foundation.dart';

class PayMongoOptions {
  final Map<String, dynamic>? data;
  final String path;
  final Map<String, String>? params;
  PayMongoOptions({
    this.data,
    required this.path,
    this.params,
  });

  PayMongoOptions copyWith(
      {Map<String, dynamic>? data,
      String? method,
      String? path,
      String? secret,
      Map<String, dynamic>? params}) {
    return PayMongoOptions(
        data: data ?? this.data,
        path: path ?? this.path,
        params: params as Map<String, String>? ?? this.params);
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'path': path,
      'params': params,
    };
  }

  factory PayMongoOptions.fromMap(Map<String, dynamic> map) {
    return PayMongoOptions(
      data: Map<String, dynamic>.from(map['data'] ?? const {}),
      path: map['path'] ?? '',
      params: map['params'] ?? '' as Map<String, String>?,
    );
  }

  String toJson() => json.encode(toMap());

  factory PayMongoOptions.fromJson(String source) =>
      PayMongoOptions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayMongoOptions(data: $data, path: $path,  params: $params)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PayMongoOptions &&
        mapEquals(other.data, data) &&
        other.path == path &&
        mapEquals(other.params, params);
  }

  @override
  int get hashCode {
    return data.hashCode ^ path.hashCode ^ params.hashCode;
  }
}
