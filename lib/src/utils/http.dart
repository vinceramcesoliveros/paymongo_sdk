import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/utils/options.dart';

class PayMongoSDK {
  final String secret;
  final String _apiUrl;
  PayMongoSDK(this.secret, [this._apiUrl = 'api.paymongo.com'])
      : assert(_apiUrl != null, " API url must not be null"),
        assert(secret != null, "API KEY must be provided");

  T _request<T>(http.Response response, String path) {
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw http.ClientException("${json['errors']}", response.request.url);
    }
    return json['data'];
  }

  Future<T> post<T>(PayMongoOptions options) async {
    final _http = PayMongoHttp(secret);
    final body = jsonEncode({"data": options.data});
    final response = await _http.post(
        Uri.https(_apiUrl, "v1${options.path}", options?.params),
        body: body);
    _http.close();
    return _request(response, options.path);
  }

  Future<T> get<T>(PayMongoOptions options) async {
    final _http = PayMongoHttp(secret);
    final uri = Uri.https(_apiUrl, "v1${options.path}", options.params);
    final response = await _http.get(uri);
    _http.close();
    return _request(response, options.path);
  }
}

class PayMongoHttp extends http.BaseClient {
  PayMongoHttp(this.apiKey);
  final String apiKey;
  final _client = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
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
