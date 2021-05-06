import '../src.dart';

class PayMongoSource {
  final String secret;
  const PayMongoSource(this.secret);

  Future<SourceResult> createSource(Source source) async {
    final options = PayMongoOptions(
      path: '/sources',
      secret: secret,
      data: source.toMap(),
    );
    final client = PayMongoClient();
    final response = await client.post(options);
    client.close();
    return SourceResult.fromJson(response);
  }

  Future<SourceResult> retreiveSource(int id) async {
    assert(id != null, "ID is required");
    final options = PayMongoOptions(path: '/sources/$id', secret: secret);
    final client = PayMongoClient();

    final response = await client.get(options);

    client.close();
    return SourceResult.fromJson(response);
  }
}
