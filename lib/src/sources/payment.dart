import '../src.dart';

extension PayMongoSource on PayMongoSDK {
  Future<SourceResult> createSource(Source source) async {
    final options = PayMongoOptions(
      path: '/sources',
      data: {
        "attributes": source.toMap(),
      },
    );

    final response = await post<Map<String, dynamic>>(options);
    return SourceResult.fromMap(response);
  }

  Future<SourceResult> retreiveSource(int id) async {
    assert(id != null, "ID is required");
    final options = PayMongoOptions(path: 'sources/$id');

    final response = await get(options);

    return SourceResult.fromMap(response);
  }
}
