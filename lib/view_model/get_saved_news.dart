import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/news_model.dart';

class SavedNewsViewModel extends ChangeNotifier {
  List<Articles> _articleList = [];

  List<Articles> get articleList => _articleList;

  Future<void> loadArticleList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articleListString = prefs.getStringList('articleList') ?? [];
    _articleList = articleListString
        .map((item) => Articles.fromJson(json.decode(item)))
        .toList();
    notifyListeners();
  }

  Future<void> addArticle(Articles article) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articleListString = prefs.getStringList('articleList') ?? [];
    _articleList = articleListString
        .map((item) => Articles.fromJson(json.decode(item)))
        .toList();
    bool articleExists = _articleList
        .any((existingArticle) => existingArticle.title == article.title);
    if (!articleExists) {
      _articleList.add(article);
    }

    _saveArticleListToPrefs();
  }

  Future<void> removeArticle(Articles articleId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articleListString = prefs.getStringList('articleList') ?? [];
    _articleList = articleListString
        .map((item) => Articles.fromJson(json.decode(item)))
        .toList();
    _articleList.removeWhere((article) => article.title == articleId.title);
    _saveArticleListToPrefs();
  }

  Future<void> _saveArticleListToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articleListString =
        _articleList.map((item) => json.encode(item.toJson())).toList();
    prefs.setStringList('articleList', articleListString);
    notifyListeners();
  }
}
