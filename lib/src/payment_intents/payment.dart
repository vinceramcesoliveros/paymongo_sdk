import '../src.dart';

class PayMongoPaymentIntent {
  final String secret;
  const PayMongoPaymentIntent(this.secret);
  Future<String> createPaymentIntent(PaymentIntentAttributes data) async {
    final options = PayMongoOptions(
      data: {'attributes': data.toMap()},
      path: '/payment_intents',
      secret: secret,
    );
    final client = PayMongoClient();
    final response = await client.post(options);
    client.close();
    return response;
  }

  Future<String> retreivePaymentIntent(int id) async {
    assert(id != null, "Payment Intent ID is required.");
    final options = PayMongoOptions(
      path: '/payment_intents/$id',
      secret: secret,
    );

    final client = PayMongoClient();
    final response = await client.get(options);
    client.close();
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
      secret: secret,
      data: {
        'attributes': data.toMap(),
      },
    );
    final client = PayMongoClient();
    final response = await client.post(options);
    client.close();
    return response;
  }
}
