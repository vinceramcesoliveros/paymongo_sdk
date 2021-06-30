import '../src.dart';

/// Instance of Source to provide a different payment gateway.
/// Options allowed are GCash and GrabPay
/// Link: https://developers.paymongo.com/docs/e-wallets-gcash-grabpay
extension PayMongoSource on PayMongoSDK {
  /// A Source resource is used to generate GCash/GrabPay checkout URL to authorize
  /// a certain amount to be deducted from your customer's GCash account
  /// and send it to your PayMongo account. After completing the authorization,
  /// your integration uses the chargeable
  /// source to make a create payment request and receive the payment.
  ///
  /// https://developers.paymongo.com/docs/accepting-gcash-payments#1-create-a-source
  ///
  /// Example:
  /// ```dart
  ///   final sdk = PayMongoSDK(payMongoKey);
  ///   final url = 'your-url-callback';
  ///   final _source = Source(
  ///     type: "gcash",
  ///     amount: _amount.toDouble(),
  ///     currency: 'PHP',
  ///     redirect: Redirect(
  ///       success: "https://$url/success",
  ///       failed: "https://$url/failed",
  ///     ),
  ///     billing: PayMongoBilling(
  ///       address: PayMongoAddress(
  ///         city: "Cotabato City",
  ///         country: "PH",
  ///         state: "Mindanao",
  ///         line1: "Secret Address",
  ///       ),
  ///       name: "Anonymous",
  ///       email: "test@gmail.com",
  ///       phone: "09123456002",
  ///     ),
  ///   );
  ///   final result = await sdk.createSource(_source);
  /// ```
  Future<SourceResult> createSource(Source source) async {
    final options = PayMongoOptions(
      path: '/sources',
      data: {
        "attributes": source.toMap(),
      },
    );

    final response = await post<Map<String, dynamic>>(options);
    return SourceResult.fromMap(response);
  }

  /// Retrieves the payment
  Future<SourceResult> retreiveSource(int id) async {
    if (id <= 0) {
      throw ArgumentError("ID must be greater than 0");
    }
    final options = PayMongoOptions(path: 'sources/$id');

    final response = await get<Map<String, dynamic>>(options);

    return SourceResult.fromMap(response);
  }
}
