import '../src.dart';

class PayMongoSource {
  final String secret;
  const PayMongoSource(this.secret);

  Future<SourceResult> createSource(Source source) async {
    final options = PayMongoOptions(
      path: '/sources',
      secret: secret,
      data: {
        "attributes": source.toMap(),
      },
    );
    final client = PayMongoClient(secret);
    final response = await client.post<Map<String, dynamic>>(options);
    client.close();
    return SourceResult.fromMap(response);
  }

  Future<SourceResult> retreiveSource(int id) async {
    assert(id != null, "ID is required");
    final options = PayMongoOptions(path: 'sources/$id', secret: secret);
    final client = PayMongoClient(secret);

    final response = await client.get(options);

    client.close();
    return SourceResult.fromMap(response);
  }
}
