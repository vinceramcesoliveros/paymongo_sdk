import 'package:paymongo_sdk/paymongo_sdk.dart';

///
enum WebhookAction {
  ///
  enable,

  ///
  disable
}

///
extension WebhookExtension on WebhookAction {
  ///
  String enumToString() {
    return toString().split(".").last;
  }
}

@Deprecated("Not usable, use `PaymongoClient` instead")

///
extension PaymongoWebhook on PayMongoSDK {
  @Deprecated("Not usable, use `PaymongoClient` instead")

  ///
  Future<String?> createWebhook(
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

  @Deprecated("Not usable, use `PaymongoClient` instead")

  ///
  Future<String?> retreiveWebhook(int id) async {
    final options = PayMongoOptions(
      data: {
        'id': id,
      },
      path: '/webhooks/$id',
    );

    final response = await get(options);

    return response;
  }

  @Deprecated("Not usable, use `PaymongoClient` instead")

  ///
  Future<String?> listWebhooks() async {
    const options = PayMongoOptions(
      path: '/webhooks',
    );

    final response = await get(options);

    return response;
  }

  @Deprecated("Not usable, use `PaymongoClient` instead")

  ///
  Future<String?> toggleWebhook(int id, WebhookAction action) async {
    final options = PayMongoOptions(
      path: '/webhooks/$id/${action.enumToString()}',
    );

    final response = await post(options);

    return response;
  }
}
