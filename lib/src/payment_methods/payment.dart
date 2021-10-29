import 'package:paymongo_sdk/paymongo_sdk.dart';
import 'package:paymongo_sdk/src/models/method/method_response.dart';

///
extension PayMongoPaymentMethod on PayMongoSDK {
  ///
  Future<PaymentResult?> onPaymentListener({
    required String paymentMethod,
    required PaymentIntentResponse intent,
  }) async {
    try {
      final paymentIntentId =
          intent.attributes.clientKey.split('_client').first;

      final clientKey = intent.attributes.clientKey;
      final attachment = await attachToPaymentIntent(
        paymentIntentId,
        PaymentIntentAttach(
          paymentMethod: paymentMethod,
          clientKey: clientKey,
        ),
      );
      switch (attachment.attributes.status) {
        case "succeeded":
          return PaymentResult(
            id: intent.id,
            clientKey: intent.attributes.clientKey,
            status: PaymentMethodStatus.succeeded,
            paymentMethod: paymentMethod,
            authenticateUrl:
                "https://api.paymongo.com/v1/payment_intents/$paymentIntentId?client_key=$clientKey",
          );
        case "awaiting_payment_method":
          return PaymentResult(
            id: intent.id,
            clientKey: intent.attributes.clientKey,
            status: PaymentMethodStatus.awaitingPaymentMethod,
            errors: intent.attributes.lastPaymentError,
            paymentMethod: paymentMethod,
          );

        case "awaiting_next_action":
          return PaymentResult(
            id: intent.id,
            clientKey: intent.attributes.clientKey,
            status: PaymentMethodStatus.awaitingPaymentMethod,
            errors: intent.attributes.lastPaymentError,
            paymentMethod: paymentMethod,
            authenticateUrl:
                "https://api.paymongo.com/v1/payment_intents/$paymentIntentId?client_key=$clientKey",
            nextAction: attachment.attributes.nextAction,
          );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentMethodResponse> createPaymentMethod({
    required PaymentMethodAttributes data,
  }) async {
    final options = PayMongoOptions(
      path: '/payment_methods',
      data: {"attributes": data.toMap()},
    );

    final response = await post<Map<String, dynamic>>(options);
    final result = PaymentMethodResponse.fromMap(response);
    return result;
  }

  Future<String> retreivePaymentMethod(int id) async {
    if (id <= 0) {
      throw ArgumentError("ID must be real number");
    }

    final options = PayMongoOptions(
      path: '/payment_methods/$id',
    );

    final response = await get(options);
    return response;
  }
}

/// {@template payment_method_client}
/// {@endtemplate}
class PaymentMethod
    with PaymentSerializer
    implements
        PublicPaymentInterface<PaymentMethodResponse, PaymentMethodAttributes> {
  /// {@macro payment_method_client}
  PaymentMethod(String apiKey, String url)
      : _apiKey = apiKey,
        _url = url;
  final String _apiKey;

  final String _url;
  @override
  Future<PaymentMethodResponse> create(
      PaymentMethodAttributes attributes) async {
    final _http = PayMongoHttp(_apiKey);
    final options = PayMongoOptions(path: '/sources', data: {
      "attributes": attributes.toMap(),
    });
    final response =
        await _http.post(Uri.https(_url, "v1${options.path}", options.params));
    _http.close();

    final json = serialize<String>(response, options.path);
    return PaymentMethodResponse.fromJson(json);
  }

  @override
  Future<PaymentMethodResponse> retrieve(int id) async {
    assert(!id.isNegative, "ID must be positive number");
    final _http = PayMongoHttp(_apiKey);
    final options = PayMongoOptions(path: 'sources/$id');

    final response =
        await _http.get(Uri.https(_url, "v1${options.path}", options.params));
    _http.close();
    final json = serialize<Map<String, dynamic>>(response, options.path);
    return PaymentMethodResponse.fromMap(json);
  }
}
