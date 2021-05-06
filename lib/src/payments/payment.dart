import '../src.dart';

extension PayMongoPayments on PayMongoClient {
  Future<String> createPayment(PaymentAttributes data,
      [int before, int after, int limit]) async {
    assert(data != null, "Data does not meet requirements");
    if (before != null) {}
    final options = PayMongoOptions(
      path: '/payments',
      secret: secret,
      data: {
        'attributes': data.toMap(),
      },
      params: {
        'before': before,
        'after': after,
        'limit': limit,
      },
    );
    final client = PayMongoClient(secret);
    final response = await client.post(options);
    client.close();
    return response;
  }

  Future<String> retreivePayment(int id) async {
    final options = PayMongoOptions(
      secret: secret,
      path: '/payments/$id',
    );
    final client = PayMongoClient(secret);
    final response = await client.get(options);
    client.close();
    return response;
  }

  Future<String> listPayments() async {
    final options = PayMongoOptions(path: '/payments', secret: secret);
    final client = PayMongoClient(secret);
    final response = await client.get(options);
    client.close();
    return response;
  }
}
