import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  // this for show toast
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

//  this for show flushbar it's called like snackbar
  static flushBarErrorMessage(String message, BuildContext context) {
    return Flushbar(
      message: message,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.error),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOutBack,
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(seconds: 3),
    ).show(context);
  }

// this function for changing the focus node to next
  static void changeFocusNext(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static Future<dynamic> launchUrlInApp(String url) async {
    // final Uri uri = Uri.parse(url);
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw toastMessage("Could not launch $url");
    }
  }

  static showPopupDailog(BuildContext context, Function() onTap) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Logout"),
              content: const Text("Are you sure you want to logout?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton(
                  onPressed: onTap,
                  child: Text(
                    "Okey",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.redAccent),
                  ),
                )
              ]);
        });
  }

  static textShare(String text) {
    Share.share(text);
  }
}
