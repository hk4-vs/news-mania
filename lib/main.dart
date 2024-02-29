import 'package:flutter/material.dart';

import 'package:news_app/utils/themes.dart';
import 'package:news_app/view/splash_view.dart';
import 'package:news_app/view_model/get_saved_news.dart';

import 'package:provider/provider.dart';

import 'utils/routes/routes.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/home_view_model.dart';
import 'view_model/user_profile_view_model.dart';
import 'view_model/user_view_model.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // debugDefaultTargetPlatformOverride =
  //     TargetPlatform.fuchsia; // or any other platform
  // debugPrintRebuildDirtyWidgets = true;
  // debugPaintSizeEnabled = true;
  // GestureBinding.instance.resamplingEnabled = true;

  // // Enable use_build_context_synchronously
  // debugInvertOversizedImages = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<AuthViewModel>(create: (_) => AuthViewModel()),
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
        ChangeNotifierProvider<UserViewModel>(create: (_) => UserViewModel()),
        ChangeNotifierProvider<HomeViewViewModel>(
            create: (_) => HomeViewViewModel()),
        ChangeNotifierProvider<UserProfileViewModel>(
            create: (_) => UserProfileViewModel()),
        ChangeNotifierProvider<SavedNewsViewModel>(
            create: (_) => SavedNewsViewModel()),
      ],
      child: MaterialApp(
        title: 'News Mania',
        // initialRoute: RouteNames.splashView,

        home: const SplashView(),
        onGenerateRoute: Routes.genrateRoute,
        debugShowCheckedModeBanner: false,
        theme: MyThemes.lightTheme(),
      ),
    );
  }
}
