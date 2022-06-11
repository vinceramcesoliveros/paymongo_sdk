import 'package:paymongo_sdk/paymongo_sdk.dart';

///{@template refund}
///{@endtemplate}
class Refund<T extends PaymentGateway>
    with
        PaymentResponseSerializer
    implements
        SecretPaymentInterface<RefundResponse, CreateRefundAttributes,
            ListAllRefundQueryParams, ListAllRefundResponse> {
  ///{@macro refund}
  Refund(
    String apiKey,
    String url, [
    T? httpClient,
  ]) : _http = httpClient ??
            PaymentGateway(
              url: url,
              apiKey: apiKey,
            ) as T;

  final T _http;
  @override
  Future<RefundResponse> create(CreateRefundAttributes attributes) async {
    final options = PayMongoOptions(
      path: '/refunds',
      data: {
        "attributes": attributes.toMap(),
      },
    );

    final response = await _http.post(options);
    final json = serialize<Map<String, dynamic>>(
      response,
      options.path,
      onSerializedCallback: (json) => json as Map<String, dynamic>,
    );
    return RefundResponse.fromMap(json);
  }

  @override
  Future<ListAllRefundResponse> listAll([
    ListAllRefundQueryParams? queryParams,
  ]) async {
    final options = PayMongoOptions(
      path: '/refunds',
      params: queryParams?.toMap(),
    );

    final response = await _http.fetch(options);
    final json = serialize<Map<String, dynamic>>(
      response,
      options.path,
      onSerializedCallback: (json) => json as Map<String, dynamic>,
    );
    return ListAllRefundResponse.fromMap(json);
  }

  @override
  Future<RefundResponse> retrieve(int id) async {
    final options = PayMongoOptions(
      path: '/refunds/$id',
    );
    final response = await _http.fetch(options);
    final json = serialize<Map<String, dynamic>>(
      response,
      options.path,
      onSerializedCallback: (json) => json as Map<String, dynamic>,
    );
    return RefundResponse.fromMap(json);
  }
}
