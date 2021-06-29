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
    if (id.runtimeType != int) {
      throw ArgumentError("ID is required");
    }
    if (id <= 0) {
      throw ArgumentError("ID must be greater than 0");
    }
    final options = PayMongoOptions(path: 'sources/$id');

    final response = await get<Map<String, dynamic>>(options);

    return SourceResult.fromMap(response);
  }
}
