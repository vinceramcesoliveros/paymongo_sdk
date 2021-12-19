import 'package:paymongo_sdk/paymongo_sdk.dart';

/// {@template paymongo_client_sdk}
/// {@endtemplate}
class PaymongoClient<T extends Paymongo> {
  /// {@macro paymongo_client_sdk}
  const PaymongoClient(String key,
      {String url = 'api.paymongo.com', T? defaultSDK})
      : _key = key,
        _sdk = defaultSDK,
        _url = url;
  final String _key;
  final T? _sdk;
  final String _url;

  /// Retrieve the instance of [Paymongo] to access private or public APIs.
  T get instance {
    final keyType = _key.split('_').first;
    if (keyType.contains(privateKey)) {
      return (PaymongoSecret()
        ..key = _key
        ..url = _url) as T;
    } else if (keyType.contains(publicKey)) {
      return (PaymongoPublic()
        ..key = _key
        ..url = _url) as T;
    } else if (_sdk != null) {
      return _sdk!;
    }
    throw PaymongoError("Key does not match with private or secret key");
  }
}
