import 'package:flutter/material.dart';
import 'package:news_app/view/forgot_password.dart';
import 'package:news_app/view/saved_news_view.dart';
import 'package:news_app/view/user_profile/user_profile_view.dart';

import '../../view/home_view.dart';
import '../../view/login_view.dart';
import '../../view/register_view.dart';
import '../../view/splash_view.dart';
import 'routes_names.dart';

class Routes {
  static Route<dynamic> genrateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => const HomeScreenView());
      case RouteNames.register:
        return MaterialPageRoute(
            builder: (context) => const UserRegisterView());
      case RouteNames.splashView:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case RouteNames.forgetPassword:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordPage());
      case RouteNames.userProfileView:
        return MaterialPageRoute(builder: (context) => const UserProfileView());
        // case RouteNames.savedNewsView:
        // return MaterialPageRoute(builder: (context) =>  SavedNewsView());
     

      default:
        return MaterialPageRoute(builder: (context) => const LoginView());
    }
  }
}
