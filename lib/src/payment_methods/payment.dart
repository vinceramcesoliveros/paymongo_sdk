import 'package:paymongo_sdk/paymongo_sdk.dart';

import '../models/models.dart';
import '../src.dart';

extension PayMongoPaymentMethod on PayMongoClient {
  Future<String> createPaymentMethod({
    PaymentMethod data,
  }) async {
    final options = PayMongoOptions(
      path: '/payment_methods',
      data: data.toMap(),
    );

    final response = await post(options);
    return response;
  }

  Future<String> retreivePaymentMethod(int id) async {
    assert(id != null, "Payment Method ID is required");

    final options = PayMongoOptions(
      path: '/payment_methods/$id',
    );

    final response = await get(options);
    return response;
  }
}
