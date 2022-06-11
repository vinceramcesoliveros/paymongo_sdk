import 'package:paymongo_sdk/paymongo_sdk.dart';

///
extension PayMongoPaymentMethod on PayMongoSDK {
  @Deprecated("Use PaymongoClient instead")

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
    return null;
  }

  @Deprecated("Use PaymongoClient instead")

  ///
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

  @Deprecated("Use PaymongoClient instead")

  ///
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
class PaymentMethod<T extends PaymentGateway>
    with PaymentResponseSerializer
    implements
        PublicPaymentInterface<PaymentMethodResponse, PaymentMethodAttributes> {
  /// {@macro payment_method_client}
  PaymentMethod(String apiKey, String url, [T? httpClient])
      : _httpClient =
            httpClient ?? PaymentGateway(apiKey: apiKey, url: url) as T;
  final T _httpClient;
  @override
  Future<PaymentMethodResponse> create(
    PaymentMethodAttributes attributes,
  ) async {
    final options = PayMongoOptions(
      path: '/payment_methods',
      data: {
        "attributes": attributes.toMap(),
      },
    );
    final response = await _httpClient.post(options);
    final json = serialize<Map<String, dynamic>>(response, options.path);
    return PaymentMethodResponse.fromMap(json);
  }

  @override
  Future<PaymentMethodResponse> retrieve(int id) async {
    assert(!id.isNegative, "ID must be positive number");
    final options = PayMongoOptions(path: 'sources/$id');

    final response = await _httpClient.fetch(options);
    final json = serialize<Map<String, dynamic>>(response, options.path);
    return PaymentMethodResponse.fromMap(json);
  }
}
