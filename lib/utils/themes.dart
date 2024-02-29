import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData lightTheme() {
    return ThemeData(
        primaryColor: const Color(0xffFF00FF),
        fontFamily: "mukta",
        // primaryColorLight: const Color(0xff9BABB8),
        // primaryColorDark: const Color(0xffB83B5E),
        // disabledColor: const Color(0xff888888),
        // highlightColor: const Color(0xffF9ED69),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.white,
            onPrimary: Color(0xff9BABB8),
            secondary: Color(0xffB83B5E),
            onSecondary: Color(0xffB83B6F),
            error: Color(0xffB83B5E),
            onError: Color(0xffB83B5E),
            background: Color(0xff1a1817),
            onBackground: Color(0xffE1D4BB),
            surface: Color(0xffF5F0BB),
            onSurface: Color(0xffDBDFAA)),
        textTheme: const TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontWeight: FontWeight.w600),
            bodyLarge: TextStyle(fontWeight: FontWeight.w600)),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xffF6F7F9),
          focusColor: const Color(0xffFF00FF),
          contentPadding: const EdgeInsets.only(left: 24),

          // hintStyle: Theme.of(context)
          //     .textTheme
          //     .bodyMedium!
          //     .copyWith(color: Colors.black26),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffFF00FF),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(50),
            gapPadding: 8.0,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black12, // Set the border color
              width: 2.0, // Set the border width
            ),
            borderRadius: BorderRadius.circular(50),
            gapPadding: 8.0,
          ),
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Color(0xffFF00FF)));
  }
}
