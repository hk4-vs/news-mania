import 'package:flutter/material.dart';
import 'package:news_app/resources/local_storage_keys.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/login_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(LoginModel userModel) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(
        LocalStorageKeys.accessToken, userModel.accessToken.toString());
    preferences.setString(
        LocalStorageKeys.name, userModel.user!.name.toString());
    preferences.setString(
        LocalStorageKeys.email, userModel.user!.email.toString());
    preferences.setString(
        LocalStorageKeys.profileImage, userModel.user!.profileImage.toString());
    // preferences.setString("user", userModel.user.toString());
    notifyListeners();
    return true;
  }

  Future<LoginModel> getUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(LocalStorageKeys.accessToken);
    final String? name = preferences.getString(LocalStorageKeys.name);
    final String? email = preferences.getString(LocalStorageKeys.email);
    final String? profileImage =
        preferences.getString(LocalStorageKeys.profileImage);
    return LoginModel(
        accessToken: token,
        user: User(name: name, email: email, profileImage: profileImage));
  }

  Future<bool> updateUserToSaveData(String field, String data) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(field, data);

    notifyListeners();
    return true;
  }

  Future<bool> removeData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }
}
