import '../../paymongo_sdk.dart';

extension PaymongoToken on PayMongoSDK {
  Future<Map<String, dynamic>?> retreiveToken(int id) async {
    final options = PayMongoOptions(
      path: '/tokens/$id',
    );

    final response = await get<Map<String, dynamic>>(options);
    return response;
  }
}
