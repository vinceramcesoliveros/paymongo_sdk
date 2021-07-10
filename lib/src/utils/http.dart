import 'dart:convert';

import 'package:http/http.dart' as _http;
import '../src.dart';

///
/// ### 🚧 DO NOT USE SECRET KEY IN PRODUCTION
/// {@template paymonggosdk}
/// Following methods will use secret key
///
/// - [createPayment]
/// Initialize PayMongo SDK.
///
///
/// The code provided is an example of using a secret key
/// ```dart
/// final publicKeyClient = PayMongoSDK(publicKey);
/// final secretKeyClient = PayMongoSDK(secretKey);
/// ```
/// {@endtemplate}
class PayMongoSDK {
  /// {@macro paymonggosdk}
  PayMongoSDK(this.secret, {this.http, String apiUrl = 'api.paymongo.com'})
      : _apiUrl = apiUrl;

  /// key generated from paymongo dashboard
  /// you can use `--dart-define` command to store your private key.
  final String secret;
  final String _apiUrl;

  /// custom http. be sure you include your api key to have basic base64
  /// authorization headers.
  final _http.BaseClient? http;
  T _request<T>(_http.Response response, String path) {
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw _http.ClientException("${json['errors']}", response.request?.url);
    }
    return json?['data'] as T;
  }

  /// make POST response.
  Future<T> post<T>(PayMongoOptions options) async {
    final _http = http ?? PayMongoHttp(secret);
    final body = jsonEncode({"data": options.data});
    final response = await _http.post(
        Uri.https(_apiUrl, "v1${options.path}", options.params),
        body: body);
    _http.close();
    return _request(response, options.path);
  }

  /// make GET response
  Future<T> get<T>(PayMongoOptions options) async {
    final _http = http ?? PayMongoHttp(secret);
    final uri = Uri.https(_apiUrl, "v1${options.path}", options.params);
    final response = await _http.get(uri);
    _http.close();
    return _request(response, options.path);
  }
}

/// {@template paymongohttp}
/// Alternative HTTP client. can be extensible for custom http
/// client. use [base64] to generate authorization key.
/// {@endtemplate}
///
class PayMongoHttp extends _http.BaseClient {
  /// {@macro paymongohttp}
  PayMongoHttp(this.apiKey);

  /// uses public or secret PayMongo key.
  final String apiKey;
  @override
  Future<_http.StreamedResponse> send(_http.BaseRequest request) {
    final _client = _http.Client();
    final bytes = utf8.encode(apiKey);
    final base64Str = base64.encode(bytes);
    final headers = {
      'Authorization': 'Basic $base64Str',
      'Content-Type': 'application/json'
    };

    request.headers.addAll(headers);
    return _client.send(request);
  }
}
