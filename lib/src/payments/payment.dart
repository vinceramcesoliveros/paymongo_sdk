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
  @Deprecated("Use Payment.listAll")
  Future<List<PaymentResource>> listPayments() async {
    final options = PayMongoOptions(path: '/payments');
    final response = await get<List<Map<String, dynamic>>>(options);
    return response.map((data) => PaymentResource.fromMap(data)).toList();
  }
}

///{@template secret_payment_client}
///{@endtemplate}
class Payment
    with
        PaymentSerializer
    implements
        SecretPaymentInterface<PaymentAttributesResponse, PaymentAttributes,
            PaymentListQueryParams> {
  ///{@macro secret_payment_client}
  Payment(String apiKey, String url)
      : _apiKey = apiKey,
        _url = url;

  ///
  final String _apiKey;

  ///
  final String _url;

  @override
  Future<PaymentAttributesResponse> create(PaymentAttributes attributes) async {
    final options = PayMongoOptions(
      path: '/payments',
      data: {
        'attributes': attributes.toMap(),
      },
    );

    final _http = PayMongoHttp(_apiKey);
    final response =
        await _http.post(Uri.https(_url, "v1${options.path}", options.params));
    _http.close();

    final json = serialize<String>(response, options.path);
    return PaymentAttributesResponse.fromJson(json);
  }

  @override
  Future<PaymentAttributesResponse> listAll(PaymentAttributes attributes,
      [PaymentListQueryParams? queryParams]) async {
    final options = PayMongoOptions(
      path: '/payments',
      params: queryParams?.toMap(),
    );
    final _http = PayMongoHttp(_apiKey);
    final response =
        await _http.get(Uri.https(_url, "v1${options.path}", options.params));
    _http.close();

    final json = serialize<String>(response, options.path);

    return PaymentAttributesResponse.fromJson(json);
  }

  @override
  Future<PaymentAttributesResponse> retrieve(int id) async {
    final options = PayMongoOptions(
      path: '/payments/$id',
    );
    final _http = PayMongoHttp(_apiKey);
    final response =
        await _http.get(Uri.https(_url, "v1${options.path}", options.params));
    _http.close();

    final json = serialize<String>(response, options.path);

    return PaymentAttributesResponse.fromJson(json);
  }
}
