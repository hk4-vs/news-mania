import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  // Map<String, String> headers = {
  //   "Accept": "application/json",
  //   // "Content-Type": "application/json"
  // };
  @override
  Future<dynamic> getGetApiResponses(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(
            const Duration(seconds: 20),
          );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future getPostApiResponses(
    String url,
    dynamic data,
  ) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

// this function for uploading image

  // Future getPostImagesApiResponses(
    
  //   File? pickedImage,
    
  // ) async {
  //   dynamic responseJson;
  //   try {
  //      Future<LoginModel> getUserData() => UserViewModel().getUser();
  //      getUserData().then((value) async{
  //       http.MultipartRequest request =
  //         http.MultipartRequest('POST', Uri.parse(AppUrls.uploadUserProfile));
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'profile_image',
  //       pickedImage!.path,
  //       filename: path.basename(pickedImage.path),
  //     ));
  //     request.headers['Authorization'] = 'Bearer ${value.accessToken}';
  //     request.headers['Content-Type'] = 'multipart/form-data';

  //     var response = await request.send();

  //     responseJson = returnResponse(response);


  //      } );
      
  //   } on SocketException {
  //     throw FetchDataException("No Internet Connection");
  //   }

  //   return responseJson;
  // }

  dynamic returnResponse(var response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BedRequestException(response.body.toString());
      case 403:
        throw UnAuthrizedException(response.body.toString());
      case 500:
        throw UnAuthrizedException(response.body.toString());

      default:
        throw FetchDataException(
            "Error accured while communicating with serverwith status code ${response.statusCode}");
    }
  }
}
