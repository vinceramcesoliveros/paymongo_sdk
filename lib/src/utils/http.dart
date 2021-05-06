import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/utils/options.dart';

class PayMongoClient {
  final http.BaseClient _http;

  PayMongoClient({
    http.BaseClient client,
  }) : _http = client;
  void close() {
    _http.close();
  }

  static String _payMongoUrl = '';
  static set payMongoUrl(String url) => _payMongoUrl = url;
  String _request(http.Response response, String path) {
    final json = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw HttpException(json['errors'], uri: response.request.url);
    }
    return json['data'];
  }

  Future<String> post(PayMongoOptions options) async {
    final response =
        await _http.post(Uri.https(_payMongoUrl, options.path, options.params));
    return _request(response, options.path);
  }

  Future<String> get(PayMongoOptions options) async {
    final uri = Uri.https(_payMongoUrl, options.path);
    final response = await http.get(uri);
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
    final headers = {'Authorization': 'Basic $base64Str'};

    request.headers.addAll(headers);
    return _client.send(request);
  }
}
