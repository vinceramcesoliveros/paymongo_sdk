import 'dart:convert';

import 'package:paymongo_sdk/paymongo_sdk.dart';

///
enum WebhookAction {
  ///
  enable,

  ///
  disable
}

/// {@template paymongo_webhook}
/// {@endtemplate}
class PaymongoWebhook<T extends PaymentGateway>
    implements WebhookInterface<WebhookResponse> {
  /// {@macro paymongo_webhook}
  PaymongoWebhook(String apiKey, String url, {T? httpClient})
      : _httpClient =
            httpClient ?? PaymentGateway(url: url, apiKey: apiKey) as T;

  final T _httpClient;
  @override
  Stream<WebhookResponse> create() {
    return _httpClient
        .post(const PayMongoOptions(path: "/webhooks"))
        .asStream()
        .asyncMap((event) => WebhookResponse.fromJson(event.body));
  }

  @override
  Future<WebhookResponse> disable(String id) async {
    final result =
        await _httpClient.post(PayMongoOptions(path: "/webhook/$id/disable"));
    return WebhookResponse.fromJson(result.body);
  }

  @override
  Future<WebhookResponse> enable(String id) async {
    final result =
        await _httpClient.post(PayMongoOptions(path: "/webhook/$id/enable"));
    return WebhookResponse.fromJson(result.body);
  }

  @override
  Stream<List<WebhookResponse>> listAll() {
    return _httpClient
        .fetch(const PayMongoOptions(path: "/webhooks"))
        .asStream()
        .asyncMap((event) {
      final json = event.body;
      final items = jsonDecode(json);
      if (items is List) {
        return items.map((e) => WebhookResponse.fromMap(e)).toList();
      }
      return [];
    });
  }

  @override
  Stream<WebhookResponse> retrieve(String id) {
    return _httpClient
        .fetch(PayMongoOptions(path: "/webhook/$id"))
        .asStream()
        .asyncMap((event) => WebhookResponse.fromJson(event.body));
  }
}
