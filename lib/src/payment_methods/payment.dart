import 'package:paymongo_sdk/paymongo_sdk.dart';

import '../models/models.dart';
import '../src.dart';

extension PayMongoPaymentMethod on PayMongoSDK {
  Future<String> createPaymentMethod({
    required PaymentMethod data,
  }) async {
    final options = PayMongoOptions(
      path: '/payment_methods',
      data: data.toMap(),
    );

    final response = await post<String>(options);
    return response;
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
