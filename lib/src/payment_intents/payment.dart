import '../src.dart';

extension PayMongoPaymentIntent on PayMongoClient {
  Future<String> createPaymentIntent(PaymentIntentAttributes data) async {
    final options = PayMongoOptions(
      data: {'attributes': data.toMap()},
      path: '/payment_intents',
    );
    final response = await post(options);

    return response;
  }

  Future<String> retreivePaymentIntent(int id) async {
    assert(id != null, "Payment Intent ID is required.");
    final options = PayMongoOptions(
      path: '/payment_intents/$id',
    );

    final response = await get(options);

    return response;
  }

  Future<String> attachToPaymentIntent(
    int id,
    PaymentIntentAttach data,
  ) async {
    assert(id != null, "Payment Intent ID is required");
    assert(data?.toMap()?.isNotEmpty ?? true, "Data is required");
    final options = PayMongoOptions(
      path: '/payment_intents/$id/attach',
      data: {
        'attributes': data.toMap(),
      },
    );
    final response = await post(options);
    return response;
  }
}
