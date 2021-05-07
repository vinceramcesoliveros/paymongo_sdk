import '../src.dart';

extension PayMongoPayments on PayMongoSDK {
  Future<PaymentResource> createPayment(PaymentAttributes data,
      [int before, int after, int limit]) async {
    assert(data != null, "Data does not meet requirements");
    if (before != null) {}
    final options = PayMongoOptions(
      path: '/payments',
      data: {
        'attributes': data.toMap(),
      },
      params: {
        'before': "$before",
        'after': "$after",
        'limit': "$limit",
      },
    );

    final response = await post<Map<String, dynamic>>(options);

    return PaymentResource.fromMap(response);
  }

  Future<PaymentResource> retreivePayment(int id) async {
    final options = PayMongoOptions(
      path: '/payments/$id',
    );

    final response = await get<Map<String, dynamic>>(options);

    return PaymentResource.fromMap(response);
  }

  Future<List<PaymentResource>> listPayments() async {
    final options = PayMongoOptions(path: '/payments');

    final response = await get<List<Map<String, dynamic>>>(options);

    return response.map((data) => PaymentResource.fromMap(data));
  }
}
