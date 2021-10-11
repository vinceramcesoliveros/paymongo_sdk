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
      final paymentIntentId = intent.attributes.clientKey.split('_client')[0];

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
          break;
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
