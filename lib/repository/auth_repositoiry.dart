

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_urls.dart';

class AuthRepositoiry {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponses(AppUrls.login, data);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

   Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponses(AppUrls.register, data);
      return response;
    } catch (ex) {
      rethrow;
    }
  }

   Future<dynamic> logOutApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponses(AppUrls.logout, data);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
