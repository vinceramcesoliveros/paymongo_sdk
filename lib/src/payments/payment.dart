import 'package:paymongo_sdk/paymongo_sdk.dart';

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
  Future<CreatePaymentResponse> createPayment(CreatePaymentAttributes data,
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

    return CreatePaymentResponse.fromMap(response);
  }

  /// Retreive payment by ID
  Future<CreatePaymentResponse> retreivePayment(int id) async {
    final options = PayMongoOptions(
      path: '/payments/$id',
    );

    final response = await get<Map<String, dynamic>>(options);
    return CreatePaymentResponse.fromMap(response);
  }

  /// Get all payments
  @Deprecated("Use Payment.listAll")
  Future<List<CreatePaymentResponse>> listPayments() async {
    const options = PayMongoOptions(path: '/payments');
    final response = await get<List<Map<String, dynamic>>>(options);
    return response.map((e) => CreatePaymentResponse.fromMap(e)).toList();
  }
}

///{@template secret_payment_client}
///{@endtemplate}
class Payment<T extends PaymentGateway>
    with
        PaymentResponseSerializer
    implements
        SecretPaymentInterface<PaymentAttributesResponse,
            CreatePaymentAttributes, PaymentListQueryParams> {
  ///{@macro secret_payment_client}
  Payment(String apiKey, String url, [T? httpClient])
      : _httpClient =
            httpClient ?? PaymentGateway(apiKey: apiKey, url: url) as T;

  final T _httpClient;
  @override
  Future<PaymentAttributesResponse> create(
      CreatePaymentAttributes attributes) async {
    final options = PayMongoOptions(
      path: '/payments',
      data: {
        'attributes': attributes.toMap(),
      },
    );
    final response = await _httpClient.post(options);

    final json = serialize<String>(response, options.path);
    return PaymentAttributesResponse.fromJson(json);
  }

  @override
  Future<PaymentAttributesResponse> listAll(CreatePaymentAttributes attributes,
      [PaymentListQueryParams? queryParams]) async {
    final options = PayMongoOptions(
      path: '/payments',
      params: queryParams?.toMap(),
    );
    final response = await _httpClient.fetch(options);

    final json = serialize<String>(response, options.path);

    return PaymentAttributesResponse.fromJson(json);
  }

  @override
  Future<PaymentAttributesResponse> retrieve(int id) async {
    final options = PayMongoOptions(
      path: '/payments/$id',
    );

    final response = await _httpClient.fetch(options);
    final json = serialize<String>(response, options.path);

    return PaymentAttributesResponse.fromJson(json);
  }
}
