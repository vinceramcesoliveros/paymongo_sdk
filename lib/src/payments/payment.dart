import '../src.dart';

class PayMongoPayments {
  final String _secret;
  const PayMongoPayments(this._secret);

  Future<String> createPayment(PaymentAttributes data,
      [int before, int after, int limit]) async {
    assert(data != null, "Data does not meet requirements");
    if (before != null) {}
    final options = PayMongoOptions(
      path: '/payments',
      secret: _secret,
      data: {
        'attributes': data.toMap(),
      },
      params: {
        'before': before,
        'after': after,
        'limit': limit,
      },
    );
    final client = PayMongoClient();
    final response = await client.post(options);
    client.close();
    return response;
  }

  Future<String> retreivePayment(int id) async {
    final options = PayMongoOptions(
      secret: _secret,
      path: '/payments/$id',
    );
    final client = PayMongoClient();
    final response = await client.get(options);
    client.close();
    return response;
  }

  Future<String> listPayments() async {
    final options = PayMongoOptions(path: '/payments', secret: _secret);
    final client = PayMongoClient();
    final response = await client.get(options);
    client.close();
    return response;
  }
}
