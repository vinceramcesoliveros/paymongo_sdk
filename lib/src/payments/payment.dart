import '../src.dart';

class PayMongoPayments {
  final String secret;
  const PayMongoPayments(this.secret);

  Future<String> createPayment(PaymentIntentAttributes data) async {
    assert(data != null, "Data does not meet requirements");
    final options = PayMongoOptions(
      path: '/payments',
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

  Future<String> retreivePayment(int id) async {
    final options = PayMongoOptions(
      secret: secret,
      path: '/payments/$id',
    );
    final client = PayMongoClient();
    final response = await client.get(options);
    client.close();
    return response;
  }

  Future<String> listPayments() async {
    final options = PayMongoOptions(path: '/payments', secret: secret);
    final client = PayMongoClient();
    final response = await client.get(options);
    client.close();
    return response;
  }
}
