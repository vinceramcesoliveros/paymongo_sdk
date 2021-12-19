import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Throws Error
class PaymongoError extends Error {
  /// Throws Error
  PaymongoError(
    this.error, {
    this.source,
    this.code,
    this.details,
  });

  /// Error message
  final String error;

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

  Map<String, dynamic> toMap() {
    return {
      'pointer': pointer,
      'attribute': attribute,
    };
  }

  ///
  String toJson() => json.encode(toMap());
}
