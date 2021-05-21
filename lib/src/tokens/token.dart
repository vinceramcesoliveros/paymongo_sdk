import '../../paymongo_sdk.dart';

// ignore: public_member_api_docs
extension PaymongoToken on PayMongoSDK {
  @Deprecated('not supported in the next version')
  Future<Map<String, dynamic>?> retreiveToken(int id) async {
    final options = PayMongoOptions(
      path: '/tokens/$id',
    );

    final response = await get<Map<String, dynamic>>(options);
    return response;
  }
}
