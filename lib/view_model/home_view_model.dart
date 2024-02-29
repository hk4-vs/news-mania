import 'package:flutter/material.dart';

import '../data/models/news_model.dart';
import '../data/response/api_response.dart';
import '../repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {
  final myRepo = HomeRepository();
  ApiResponse<NewsModel> usersList = ApiResponse.loading();
  setUsersList(ApiResponse<NewsModel> response) {
    usersList = response;
    notifyListeners();
  }

  Future<void> fetchNewsList() async {
    //  when data is loading
    setUsersList(ApiResponse.loading());
    myRepo.getListOfNews().then((value) {
      // when data is completed
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      //  when data throw some error
      setUsersList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getSearchQueryOfNews(String query) async {
    //  when data is loading
    setUsersList(ApiResponse.loading());
    myRepo.getSearchQueryOfNews(query).then((value) {
      // when data is completed
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      //  when data throw some error
      setUsersList(ApiResponse.error(error.toString()));
    });
  }
}
