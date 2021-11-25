import 'dart:convert';

import 'package:equatable/equatable.dart';

/// {@template query_payments}
/// [before] `string` - A cursor for use in pagination. before is a resource ID
///  that defines your place in the list.
///
/// For example, if you make a request and receive 10 resources,
/// starting with some_resource_id, your subsequent call can include
/// before=some_resource_id in order to fetch the previous page of the list.
///
///
///
/// [after] `string` - A cursor for use in pagination. [after] is a resource ID
/// that defines your place in the list.
///
/// For example, if you make a list request and receive 10 resources,
/// ending with some_resource_id, your subsequent call can include
/// after=some_resource_id in order to fetch the next page of the list.
/// {@endtemplate query_payments}
class PaymentListQueryParams extends Equatable {
  /// {@macro query_payments}
  const PaymentListQueryParams({
    this.before = "",
    this.after = "",
    this.limit = 10,
  });

  /// {@macro query_payments}
  factory PaymentListQueryParams.fromMap(Map<String, dynamic> map) {
    return PaymentListQueryParams(
      before: map['before'] ?? '',
      after: map['after'] ?? '',
      limit: map['limit'] ?? '',
    );
  }

  /// {@macro query_payments}
  factory PaymentListQueryParams.fromJson(String source) =>
      PaymentListQueryParams.fromMap(json.decode(source));

  ///A cursor for use in pagination. [before] is a resource ID that defines your
  /// place in the list.
  ///
  /// For example, if you make a request
  /// and receive 10 resources, starting with some_resource_id, your subsequent
  /// call can include before=some_resource_id in order to fetch the previous
  /// page of the list.
  final String before;

  /// A cursor for use in pagination. [after] is a resource ID that defines your
  ///  place in the list.
  ///
  /// For example, if you make a list request and receive 10 resources,
  /// ending with some_resource_id, your subsequent call can include
  /// after=some_resource_id in order to fetch the next page of the list.
  final String after;

  /// Limit of resources to return. If not passed, the default [limit] is 10.
  final int limit;

  /// {@macro query_payments}
  Map<String, String> toMap() {
    return {
      'before': before,
      'after': after,
      'limit': limit.toString(),
    };
  }

  /// {@macro query_payments}
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [before, after, limit];
}
