import 'package:flutter/foundation.dart';

import '../src.dart';
import '../utils/utils.dart';

enum WebhookAction { enable, disable }

extension PaymongoWebhook on PayMongoSDK {
  Future<String> createWebhook(
    final String url,
    final List<String> events,
  ) async {
    final options = PayMongoOptions(
      path: '/webhooks',
      data: {
        'attributes': {
          "url": url,
          "events": events,
        },
        "url": url,
        "events": events,
      },
    );

    final response = await post(options);

    return response;
  }

  Future<String> retreiveWebhook(int id) async {
    final options = PayMongoOptions(
      data: {
        'id': id,
      },
      path: '/webhooks/$id',
    );

    final response = await get(options);

    return response;
  }

  Future<String> listWebhooks() async {
    final options = PayMongoOptions(
      path: '/webhooks',
    );

    final response = await get(options);

    return response;
  }

  Future<String> toggleWebhook(int id, WebhookAction action) async {
    assert(id != null, "Webhook id is required");
    assert(action != null, "Invalid Action, Must be enable or disable");

    final options = PayMongoOptions(
      path: '/webhooks/$id/${describeEnum(action)}',
    );

    final response = await post(options);

    return response;
  }
}
