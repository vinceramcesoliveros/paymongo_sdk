import 'package:paymongo_sdk/src/src.dart';

/// Payment intent for CREDIT/DEBIT CARD.
extension PayMongoPaymentIntent on PayMongoSDK {
  Future<PaymentIntentResponse> retrievePaymentIntentClient({
    required String paymentIntentId,
    required String clientKey,
  }) async {
    final options =
        PayMongoOptions(path: '/payment_intents/$paymentIntentId', params: {
      'client_key': clientKey,
    });
    final response = await get<Map<String, dynamic>>(options);
    return PaymentIntentResponse.fromMap(response);
  }

  Future<String?> retreivePaymentIntent(int id) async {
    if (id <= 0) {
      throw ArgumentError("ID must be greater than 0");
    }

    final options = PayMongoOptions(
      path: '/payment_intents/$id',
    );

    final response = await get(options);

    return response;
  }

  /// {@template create_payment_intent}
  /// Create payment and call [attachToPaymentIntent] to your backend using
  /// secret key
  ///
  /// {@endtemplate}
  Future<PaymentIntentResponse> createPaymentIntent(
      PaymentIntentAttributes attributes) async {
    if (attributes.amount <= 100) {
      throw ArgumentError("Amount should be at least above P 100.00");
    }
    final options = PayMongoOptions(path: '/payment_intents', data: {
      'attributes': attributes.toMap(),
    });
    final response = await post<Map<String, dynamic>>(options);
    return PaymentIntentResponse.fromMap(response);
  }

  /// {@template attach_payment_intent}
  /// Attach payment intent to receive payment status.
  ///
  /// {@endtemplate}
  Future<PaymentIntentAttachResponse> attachToPaymentIntent(
    String id,
    PaymentIntentAttach data,
  ) async {
    if (id.isEmpty) {
      throw ArgumentError("Payment Method ID must not be empty");
    }
    final options = PayMongoOptions(
      path: '/payment_intents/$id/attach',
      data: {
        'attributes': data.toMap(),
      },
    );
    final response = await post<Map<String, dynamic>>(options);
    final result = PaymentIntentAttachResponse.fromMap(response);
    return result;
  }
}

/// {@template payment_method_client}
/// {@endtemplate}
class PaymentIntent<T extends PaymentGateway>
    with
        PaymentResponseSerializer
    implements
        PaymentIntentInterface<PaymentIntentResponse, PaymentIntentAttributes,
            PaymentIntentAttach, PaymentIntentAttachResponse> {
  /// {@macro payment_method_client}
  PaymentIntent(String apiKey, String url, [T? httpClient])
      : _apiKey = apiKey,
        _url = url,
        _http = httpClient ?? PaymentGateway(apiKey: apiKey, url: url) as T;
  final String _apiKey;
  final String _url;
  final T _http;
  @override
  Future<PaymentIntentResponse> create(
      PaymentIntentAttributes attributes) async {
    final options = PayMongoOptions(path: '/sources', data: {
      "attributes": attributes.toMap(),
    });
    final response = await _http.post(options);

    final json = serialize<Map<String, dynamic>>(response, options.path);
    return PaymentIntentResponse.fromMap(json);
  }

  /// Shortcut for using Card/PayMaya API. Must create Payment Method first
  Future<PaymentResult?> onPaymentListener({
    required String paymentMethod,
    required PaymentIntentAttributes attributes,
    Future<bool> Function(String url)? onRedirect,
  }) async {
    try {
      final intent = await create(attributes);
      final paymentIntentId =
          intent.attributes.clientKey.split('_client').first;

      if (intent.attributes.status == 'awaiting_payment_method' &&
          (intent.attributes.lastPaymentError?.isNotEmpty ?? false)) {
        throw intent.attributes.lastPaymentError ?? "Something went wrong";
      }
      final clientKey = intent.attributes.clientKey;
      final attachment = await attach(
        paymentIntentId,
        PaymentIntentAttach(
          paymentMethod: paymentMethod,
          clientKey: clientKey,
        ),
      );
      final result = await _paymentResult(
        paymentIntentId,
        clientKey,
        onRedirect: onRedirect,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentResult> _paymentResult(
    String paymentMethodId,
    String clientKey, {
    Future<bool> Function(String url)? onRedirect,
  }) async {
    final url =
        "https://api.paymongo.com/v1/payment_intents/$paymentMethodId?client_key=$clientKey";
    final attachIntent = await retrieveIntentClient(
      paymentMethodId,
      clientKey,
    );
    switch (attachIntent.attributes.status) {
      case "succeeded":
        return PaymentResult(
          id: attachIntent.id,
          clientKey: attachIntent.attributes.clientKey,
          status: PaymentMethodStatus.succeeded,
          errors: attachIntent.attributes.lastPaymentError,
          paymentMethod: paymentMethodId,
          authenticateUrl: url,
          nextAction: attachIntent.attributes.nextAction,
        );
      case "processing":
        return Future.delayed(const Duration(seconds: 1), () {
          return _paymentResult(
            paymentMethodId,
            clientKey,
          );
        });
      case "awaiting_payment_method":
        return PaymentResult(
          id: attachIntent.id,
          clientKey: attachIntent.attributes.clientKey,
          status: PaymentMethodStatus.awaitingPaymentMethod,
          errors: attachIntent.attributes.lastPaymentError,
          paymentMethod: paymentMethodId,
          authenticateUrl: url,
          nextAction: attachIntent.attributes.nextAction,
        );

      case "awaiting_next_action":
        final redirectUrl = attachIntent.attributes.nextAction?.redirect?.url;
        if (redirectUrl != null) {
          final result = await onRedirect?.call(redirectUrl);
          if (result ?? false) {
            return _paymentResult(paymentMethodId, clientKey);
          }
          return PaymentResult(
            id: attachIntent.id,
            clientKey: attachIntent.attributes.clientKey,
            status: PaymentMethodStatus.failed,
            errors: attachIntent.attributes.lastPaymentError,
            paymentMethod: paymentMethodId,
            authenticateUrl: url,
            nextAction: attachIntent.attributes.nextAction,
          );
        }
        return PaymentResult(
          id: attachIntent.id,
          clientKey: attachIntent.attributes.clientKey,
          status: PaymentMethodStatus.failed,
          errors: attachIntent.attributes.lastPaymentError,
          paymentMethod: paymentMethodId,
          authenticateUrl: url,
          nextAction: attachIntent.attributes.nextAction,
        );
      default:
        return PaymentResult(
          id: attachIntent.id,
          clientKey: attachIntent.attributes.clientKey,
          status: PaymentMethodStatus.failed,
          errors: attachIntent.attributes.lastPaymentError,
          paymentMethod: paymentMethodId,
          authenticateUrl: url,
          nextAction: attachIntent.attributes.nextAction,
        );
    }
  }

  @override
  Future<PaymentIntentResponse> retrieve(int id) async {
    assert(!id.isNegative, "ID must be positive number");
    final options = PayMongoOptions(path: 'sources/$id');

    final response = await _http.fetch(options);
    final json = serialize<Map<String, dynamic>>(response, options.path);
    return PaymentIntentResponse.fromMap(json);
  }

  @override
  Future<PaymentIntentAttachResponse> attach(
      String id, PaymentIntentAttach attributes) async {
    final _http = PayMongoHttp(_apiKey);
    final options = PayMongoOptions(
      path: '/payment_intents/$id/attach',
      data: {
        'attributes': attributes.toMap(),
      },
    );

    final response =
        await _http.post(Uri.https(_url, "v1${options.path}", options.params));
    _http.close();
    final json = serialize<Map<String, dynamic>>(response, options.path);

    return PaymentIntentAttachResponse.fromMap(json);
  }

  @override
  Future<PaymentIntentResponse> retrieveIntentClient(
      String paymentIntentId, String clientKey) async {
    final _http = PayMongoHttp(_apiKey);
    final options =
        PayMongoOptions(path: '/payment_intents/$paymentIntentId', params: {
      "client_key": clientKey,
    });

    final response =
        await _http.post(Uri.https(_url, "v1${options.path}", options.params));
    _http.close();
    final json = serialize<Map<String, dynamic>>(response, options.path);

    return PaymentIntentResponse.fromMap(json);
  }
}
