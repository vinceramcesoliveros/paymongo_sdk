import 'dart:convert';

import 'package:http/http.dart';

/// Serialize json from [String] to Dart [Object]
mixin PaymentResponseSerializer {
  /// Convert Json response to [T] and
  /// throws [ClientException] for client error response.
  T serialize<T>(Response response, String path) {
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw ClientException("${json['errors']}", response.request?.url);
    }
    if (json?['errors'] != null) {
      throw ClientException(json?['errors'], response.request?.url);
    }
    return json?['data'] as T;
  }
}
