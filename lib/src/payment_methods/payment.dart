import 'package:paymongo_sdk/paymongo_sdk.dart';

import '../models/models.dart';
import '../src.dart';

extension PayMongoPaymentMethod on PayMongoClient {
  Future<String> createPaymentMethod({
    PaymentMethod data,
  }) async {
    final options = PayMongoOptions(
      path: '/payment_methods',
      secret: secret,
      data: data.toMap(),
    );
    final client = PayMongoClient(secret);
    final response = await client.post(options);
    client.close();
    return response;
  }

  Future<String> retreivePaymentMethod(int id) async {
    assert(id != null, "Payment Method ID is required");

    final options = PayMongoOptions(
      path: '/payment_methods/$id',
      secret: secret,
    );
    final client = PayMongoClient(secret);
    final response = await client.get(options);
    client.close();
    return response;
  }
}
