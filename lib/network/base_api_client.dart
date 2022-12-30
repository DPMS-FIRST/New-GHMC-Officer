import 'package:dio/dio.dart';
import 'package:ghmc_officer/res/constants/ApiConstants/api_constants.dart';

class ApiErrorCodes {
  ApiErrorCodes._();
  static const int success = 200;
  static const int invalid = 600;
   static const int failure = 400;
}

class BaseApiClient {
  late final Dio _client = Dio(
    BaseOptions(
        baseUrl: ApiConstants.baseurl
       // headers: {'clientId': ApiConstants.clientID}
        ),
  );

  Future<dynamic> getApi(String url,
      {String contenType = "application/json"}) async {
    try {
      var respone = await _client.get(url,
          options: Options(headers: {
            'Content-Type': contenType,
          }));
      return respone.data;
    } catch (e) {
      print(e);
    }
  }
 
  Future<dynamic> postApi(String url,
      {dynamic payload, String contenType = "application/json"}) async {
    try {
      var respone = await _client.post(url,
          options: Options(headers: {
            'Content-Type': contenType,
          }),
          data: payload);
      return respone.data;
    } catch (e) {
      print(e);
    }
  }

}