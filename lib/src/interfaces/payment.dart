import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

/// Use for Retrieve/Create response via Public Key
abstract class PublicPaymentInterface<R, P> {
  /// Retrieve data [R]
  Future<R> retrieve(int id);

  /// Create data [R] along with [P]
  Future<R> create(P attributes);
}

/// Use for [retrieve],[create],[attach] endpoints via Secret Key
abstract class PaymentIntentInterface<R, P, A, AR>
    extends PublicPaymentInterface<R, P> {
  /// Attach payment
  Future<AR> attach(String id, A attributes);

  /// Retrieve payment intent. Used for re-query to check payment status
  Future<R> retrieveIntentClient(String paymentIntentId, String clientKey);
}

/// Use for [retrieve],[create],[listAll] endpoints via Secret Key
abstract class SecretPaymentInterface<R, P, QP>
    extends PublicPaymentInterface<R, P> {
  /// Pagination of Payments
  Future<R> listAll(P attributes, [QP? queryParams]);
}

/// {@template payment_gateway}
/// Http Client for [fetch]-ing and [post]-ing API.
/// handles opening and closing http
/// {@endtemplate}
class PaymentGateway extends Equatable {
  //// {@macro payment_gateway}
  const PaymentGateway({
    required this.url,
    required this.apiKey,
  });

  /// defaults to api.paymongo.com
  final String url;

  /// can be public or secret key
  final String apiKey;

  /// GET request
  Future<Response> fetch(PayMongoOptions options) async {
    final _http = PayMongoHttp(apiKey);

    final response =
        await _http.get(Uri.https(url, "v1${options.path}", options.params));
    _http.close();
    return response;
  }

  /// POST request
  Future<Response> post(PayMongoOptions options) async {
    final _http = PayMongoHttp(apiKey);

    final response = await _http.post(
      Uri.https(url, "v1${options.path}", options.params),
      body: jsonEncode({"data": options.data}),
    );
    _http.close();
    return response;
  }

  @override
  List<Object> get props => [url, apiKey];
}
