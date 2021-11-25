import 'dart:convert';

import 'package:http/http.dart';

/// Serialize json from [String] to Dart [Object]
mixin PaymentResponseSerializer {
  /// Convert Json response to [T] and
  /// throws [ClientException] for client error response.
  ///
  /// [onSerializedCallback] returns the type you want.
  ///
  /// for the Payment listAll method returns different type of
  /// json.
  T serialize<T>(Response response, String path,
      {T Function(Object json)? onSerializedCallback}) {
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw ClientException("${json['errors']}", response.request?.url);
    }
    if (json?['errors'] != null) {
      throw ClientException(json?['errors'], response.request?.url);
    }
    return onSerializedCallback?.call(json) ?? json?['data'] as T;
  }
}
