import 'dart:developer';

import '../data/models/news_model.dart';
import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<NewsModel> getListOfNews() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponses(AppUrls.topHeadlines);
      response = NewsModel.fromJson(response);
      log("hedlines log: ${response.articles}");
      return response;
    } catch (ex) {
      rethrow;
    }
  }

  Future<NewsModel> getSearchQueryOfNews(String query) async {
    String queryUrl =
        "${AppUrls.newsBaseUrl}/everything?q=$query&sortBy=publishedAt&apiKey=${AppUrls.newsApiKey}";
    log("queryUrl: $queryUrl");
    try {
      dynamic response = await _apiServices.getGetApiResponses(queryUrl);
      response = NewsModel.fromJson(response);
      log("hedlines log: ${response.articles}");
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
