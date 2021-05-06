import 'dart:convert';

import 'package:flutter/foundation.dart';

class PayMongoOptions {
  final Map<String, dynamic> data;
  final String path;
  final String secret;
  final Map<String, dynamic> params;
  PayMongoOptions({
    this.data,
    @required this.path,
    @required this.secret,
    this.params,
  });

  PayMongoOptions copyWith(
      {Map<String, dynamic> data,
      String method,
      String path,
      String secret,
      Map<String, dynamic> params}) {
    return PayMongoOptions(
        data: data ?? this.data,
        path: path ?? this.path,
        secret: secret ?? this.secret,
        params: params ?? this.params);
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'path': path,
      'secret': secret,
      'params': params,
    };
  }

  factory PayMongoOptions.fromMap(Map<String, dynamic> map) {
    return PayMongoOptions(
      data: Map<String, dynamic>.from(map['data'] ?? const {}),
      path: map['path'] ?? '',
      secret: map['secret'] ?? '',
      params: map['params'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PayMongoOptions.fromJson(String source) =>
      PayMongoOptions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PayMongoOptions(data: $data, path: $path, secret: $secret, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PayMongoOptions &&
        mapEquals(other.data, data) &&
        other.path == path &&
        other.secret == secret &&
        mapEquals(other.params, params);
  }

  @override
  int get hashCode {
    return data.hashCode ^ path.hashCode ^ secret.hashCode ^ params.hashCode;
  }
}
