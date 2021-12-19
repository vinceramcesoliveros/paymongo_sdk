import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Throws Error
class PaymongoError extends Error {
  /// Throws Error
  PaymongoError(
    this.error, {
    this.paymongoErrors,
  });

  /// Error message
  final String error;

  /// errors from paymongo
  final List<PaymongoErrorCodes?>? paymongoErrors;
}

/// {@template paymongo_error_codes}
///
/// PayMongo API is RESTful and uses conventional HTTP response codes
/// to indicate the success or failure of API requests.
/// The table below will help you identify the meaning and the implication
/// of error responses. As a general rule of thumb: Codes in the 2xx range
///  indicate success. Codes in the 4xx range indicate a failure from the
/// given information (e.g. missing API keys, invalid parameters, failed
/// transaction, etc.). Codes in the 5xx range mean that there's an unexpected
/// error on the PayMongo servers. These shouldn't happen, but when they do,
/// please inform us right away.
///
/// {@endtemplate}
class PaymongoErrorCodes extends Equatable {
  /// {@macro paymongo_error_codes}
  const PaymongoErrorCodes({
    this.code,
    this.details,
    this.source,
  });

  /// {@macro paymongo_error_codes}
  factory PaymongoErrorCodes.fromJson(String source) =>
      PaymongoErrorCodes.fromMap(json.decode(source));

  /// {@macro paymongo_error_codes}
  factory PaymongoErrorCodes.fromMap(Map<String, dynamic> map) {
    return PaymongoErrorCodes(
      code: map['code'],
      details: map['details'],
      source: map['source'] != null
          ? PaymongoErrorSource.fromMap(map['source'])
          : null,
    );
  }

  /// A string representation of a single error. This can be used as a reference
  ///  in conditional statements if you prefer to use your own error message
  ///  instead of using the `detail` error attribute.
  final String? code;

  /// A developer-friendly error message of a single error.
  /// This can also be used as an error message to inform your end users
  /// of the issue that they encountered. However, if you feel that the detail
  /// does not match your needs, you can utilize the code attribute to provide
  /// a more suitable, custom error message.
  final String? details;

  /// [PaymongoErrorSource] data
  final PaymongoErrorSource? source;

  ///
  PaymongoErrorCodes copyWith({
    String? code,
    String? details,
    PaymongoErrorSource? source,
  }) {
    return PaymongoErrorCodes(
      code: code ?? this.code,
      details: details ?? this.details,
      source: source ?? this.source,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'details': details,
      'source': source?.toMap(),
    };
  }

  ///
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [code, details, source];
}

/// {@template error_source}
/// This attribute exists If the error originated from the JSON payload.
/// If the error is related to the query parameter,
/// for example the :id parameter when retrieving a certain resource,
///  this attribute is not returned.
/// {@endtemplate}
class PaymongoErrorSource extends Equatable {
  ///{@macro error_source}
  const PaymongoErrorSource({
    required this.pointer,
    required this.attribute,
  });

  ///{@macro error_source}
  factory PaymongoErrorSource.fromMap(Map<String, dynamic> map) {
    return PaymongoErrorSource(
      pointer: map['pointer'] ?? '',
      attribute: map['attribute'] ?? '',
    );
  }

  ///{@macro error_source}
  factory PaymongoErrorSource.fromJson(String source) =>
      PaymongoErrorSource.fromMap(json.decode(source));

  /// If the payload attribute is nested, it is represented with a dot
  /// `details.card_number`  is based on this payload:
  ///
  /// ```json
  /// {
  ///   "data": {
  ///      "attributes": {
  ///         "details": {
  ///           "card_number": "abc"
  ///          }
  ///        }
  ///     }
  ///  }
  /// ```
  final String pointer;

  /// If the payload attribute is nested but you are not interested with its
  ///  position on the payload,
  /// you may just refer to the `source.attribute` instead.
  final String attribute;

  @override
  List<Object> get props => [pointer, attribute];

  ///{@macro error_source}
  PaymongoErrorSource copyWith({
    String? pointer,
    String? attribute,
  }) {
    return PaymongoErrorSource(
      pointer: pointer ?? this.pointer,
      attribute: attribute ?? this.attribute,
    );
  }

  ///
  Map<String, dynamic> toMap() {
    return {
      'pointer': pointer,
      'attribute': attribute,
    };
  }

  ///
  String toJson() => json.encode(toMap());
}
