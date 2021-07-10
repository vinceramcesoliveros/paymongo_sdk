import '../src.dart';

/// Create payment in paymongo using secret key.
///
/// _DO NOT USE IT IN PRODUCTION._
///
extension PayMongoPayments on PayMongoSDK {
  /// Creates a payment from other types of sources in PayMongo.
  ///
  /// _DO NOT USE IT IN PRODUCTION._
  ///
  /// ```dart
  /// /// your paymongo secret key
  /// final sdk = PayMongoSDK(key);
  /// final attributes = PaymentAttributes(
  ///     amount: 250,
  ///     currency: 'PHP',
  ///     description: "A Delicious H Sauce",
  ///     source: paymentSource,
  /// );
  /// final createPayment = await sdk.createPayment(attributes);
  /// ```
  Future<PaymentResource> createPayment(PaymentAttributes data,
      [int? before, int? after, int? limit]) async {
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

  /// Retreive payment by ID
  Future<PaymentResource> retreivePayment(int id) async {
    final options = PayMongoOptions(
      path: '/payments/$id',
    );

    final response = await get<Map<String, dynamic>>(options);
    return PaymentResource.fromMap(response);
  }

  /// Get all payments
  Future<List<PaymentResource>> listPayments() async {
    final options = PayMongoOptions(path: '/payments');
    final response = await get<List<Map<String, dynamic>>>(options);
    return response.map((data) => PaymentResource.fromMap(data)).toList();
  }
}
