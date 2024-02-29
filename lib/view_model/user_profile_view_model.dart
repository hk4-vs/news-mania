import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:news_app/utils/utils.dart';

import '../data/models/login_model.dart';
import 'user_view_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  Future<LoginModel> getUserData() => UserViewModel().getUser();
  String? _name;
  String? _email;
  String? _profileImage;
  String? get getName => _name;
  String? get getEmail => _email;
  String? get getProfile => _profileImage;
  setName(String name) {
    _name = name;
    notifyListeners();
  }

  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  setProfile(String profile) {
    _profileImage = profile;
    notifyListeners();
  }

  // setNameEmailProfile(String name, String email, String profile) {
  //   _name = name;
  //   _email = email;
  //   _profileImage = profile;
  //   notifyListeners();
  // }

  currentUserData() async {
    log("name: $_name");
    UserViewModel().getUser().then(
      (value) {
        log("name::: ${value.user!.name}");
        setName(value.user!.name.toString());
        setEmail(value.user!.email.toString());
        setProfile(value.user!.profileImage.toString());
      },
    ).onError((error, stackTrace) {
      Utils.toastMessage("$error");
    });
    // await getUserData().then((value) {
    //   setName(value.user!.name.toString());
    //   setEmail(value.user!.email.toString());
    //   setProfile(value.user!.profileImage.toString());
    // }).
  }
}
