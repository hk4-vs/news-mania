import 'dart:developer';

import 'package:flutter/material.dart';

import '../data/models/login_model.dart';
import '../repository/auth_repositoiry.dart';
import '../utils/routes/routes_names.dart';
import '../utils/utils.dart';
import 'user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoiry();
  bool isLoading = false;
  bool isPasswordVisibla = true;
  bool isConfirmPasswordVisibla = false;
  bool get loading => isLoading;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    UserViewModel userPrefrences = UserViewModel();

    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);

      log("My values: ${value['access_token']}");

      LoginModel loginModel = LoginModel(
          accessToken: value['access_token'],
          message: value['message'],
          user: User.fromJson(value['user']));
      userPrefrences.saveUser(loginModel);

      Utils.toastMessage("Login Successful");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, RouteNames.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      log(error.toString());
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

// This function for creating new user it's called Register function
  Future<void> registerApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.registerApi(data).then((value) {
      setLoading(false);

      log("response log: $value");

      Utils.toastMessage("Register Successful. Please login");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }).onError((error, stackTrace) {
      setLoading(false);
      log(error.toString());
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
// this fun are uncomment when i'm done it
//   Future<void> logoutApi(dynamic data, BuildContext context)async{

//  setLoading(true);
//     _myRepo.logOutApi(data).then((value) {
//       setLoading(false);

//       log("response log: $value");

//       Utils.toastMessage("Logout Successful.");
//       Navigator.popUntil(context, (route) => route.isFirst);
//       Navigator.pushReplacementNamed(context, RouteNames.login);
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       log(error.toString());
//       Utils.flushBarErrorMessage(error.toString(), context);
//     });
//   }
}
