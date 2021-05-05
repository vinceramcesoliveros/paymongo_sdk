import 'package:flutter/foundation.dart';

import '../src.dart';
import '../utils/utils.dart';

enum WebhookAction { enable, disable }

class PaymongoWebhook {
  final String secret;
  const PaymongoWebhook(this.secret);
  Future<String> createWebhook(
    final String url,
    final List<String> events,
  ) async {
    final options = PayMongoOptions(
      path: '/webhooks',
      secret: secret,
      data: {
        'attributes': {
          "url": url,
          "events": events,
        },
        "url": url,
        "events": events,
      },
    );
    final client = PayMongoClient();
    final response = await client.post(options);
    client.close();
    return response;
  }

  Future<String> retreiveWebhook(int id) async {
    final options = PayMongoOptions(
      data: {
        'id': id,
      },
      path: '/webhooks/$id',
      secret: secret,
    );
    final client = PayMongoClient();
    final response = await client.get(options);
    client.close();
    return response;
  }

  Future<String> listWebhooks() async {
    final options = PayMongoOptions(
      path: '/webhooks',
      secret: secret,
    );
    final client = PayMongoClient();
    final response = await client.get(options);
    client.close();
    return response;
  }

  Future<String> toggleWebhook(int id, WebhookAction action) async {
    assert(id != null, "Webhook id is required");
    assert(action != null, "Invalid Action, Must be enable or disable");

    final options = PayMongoOptions(
      path: '/webhooks/$id/${describeEnum(action)}',
      secret: secret,
    );
    final client = PayMongoClient();
    final response = await client.post(options);
    client.close();
    return response;
  }
}
