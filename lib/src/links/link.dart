import 'package:paymongo_sdk/paymongo_sdk.dart';

class PaymongoLink<T extends PaymentGateway>
    with PaymentResponseSerializer
    implements LinkInterface<LinkResponse, CreateLinkAttributes> {
  PaymongoLink({
    required String url,
    required String apiKey,
    T? httpclient,
  }) : _httpClient = httpclient ??
            PaymentGateway(
              url: url,
              apiKey: apiKey,
            ) as T;

  final T _httpClient;
  @override
  Future<LinkResponse> create(CreateLinkAttributes attributes) async {
    final options = PayMongoOptions(
      path: '/links',
      data: {
        'attributes': attributes.toMap(),
      },
    );
    final response = await _httpClient.post(options);

    final json = serialize<Map<String, dynamic>>(response, options.path);
    return LinkResponse.fromMap(json);
  }

  @override
  Future<LinkResponse> retrieve(int id) async {
    final options = PayMongoOptions(
      path: '/links/$id',
    );
    final response = await _httpClient.fetch(options);

    final json = serialize<Map<String, dynamic>>(response, options.path);
    return LinkResponse.fromMap(json);
  }

  @override
  Future<LinkResponse> archiveLink(String id) async {
    final options = PayMongoOptions(
      path: '/links/$id/archive',
    );
    final response = await _httpClient.post(options);

    final json = serialize<Map<String, dynamic>>(response, options.path);
    return LinkResponse.fromMap(json);
  }

  @override
  Future<LinkResponse> getLink(String referenceNumber) async {
    final options = PayMongoOptions(
      path: '/links',
      data: {
        'reference_number': referenceNumber,
      },
    );
    final response = await _httpClient.fetch(options);

    final json = serialize<Map<String, dynamic>>(response, options.path);
    return LinkResponse.fromMap(json);
  }

  @override
  Future<LinkResponse> unarchiveLink(String id) async {
    final options = PayMongoOptions(
      path: '/links/$id/unarchive',
    );
    final response = await _httpClient.post(options);

    final json = serialize<Map<String, dynamic>>(response, options.path);
    return LinkResponse.fromMap(json);
  }
}
