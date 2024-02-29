import 'dart:developer';

import 'package:flutter/material.dart';

import '../../data/models/login_model.dart';
import '../../utils/routes/routes_names.dart';
import '../../utils/utils.dart';
import '../user_view_model.dart';

class SplashService {
  Future<LoginModel> getUserData() => UserViewModel().getUser();
  void checkAuthentication(BuildContext context) {
    getUserData().then((value) {
      Future.delayed(const Duration(seconds: 3));
      // if (!context.mounted) return;
      log("value: ${value.accessToken}");
      log("all values : ${value.message}");
      if (value.accessToken == 'null' ||
          value.accessToken == "" ||
          value.accessToken == null) {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.login,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.home,
        );
      }
    }).onError((error, stackTrace) =>
        Utils.flushBarErrorMessage(error.toString(), context));
  }
}
