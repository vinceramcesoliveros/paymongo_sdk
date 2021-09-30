import 'package:paymongo_sdk/src/src.dart';

extension PayMongoPaymentIntent on PayMongoSDK {
  Future<String?> retreivePaymentIntent(int id) async {
    if (id <= 0) {
      throw ArgumentError("ID must be greater than 0");
    }

    final options = PayMongoOptions(
      path: '/payment_intents/$id',
    );

    final response = await get(options);

    return response;
  }

  Future<PaymentIntentResponse> createPaymentIntent(
      PaymentIntentAttributes attributes) async {
    if (attributes.amount <= 100) {
      throw ArgumentError("Amount should be at least above P 100.00");
    }
    final options = PayMongoOptions(path: '/payment_intents', data: {
      'attribues': attributes.toMap(),
    });
    final response = await post<Map<String, dynamic>>(options);
    return PaymentIntentResponse.fromMap(response);
  }

  Future<Map<String, dynamic>> attachToPaymentIntent(
    int id,
    PaymentIntentAttach data,
  ) async {
    if (id <= 0) {
      throw ArgumentError("id must be real integer");
    }
    final options = PayMongoOptions(
      path: '/payment_intents/$id/attach',
      data: {
        'attributes': data.toMap(),
      },
    );
    final response = await post<Map<String, dynamic>>(options);
    return response;
  }
}
