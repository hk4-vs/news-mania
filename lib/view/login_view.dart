import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/routes/routes_names.dart';

import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, provider, child) {
      return Scaffold(
        body: provider.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: CircleAvatar(
                                backgroundColor:
                                    const Color(0xffCC04E6).withOpacity(0.1),
                                radius: 50.0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/splash_image.png"))),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Text(
                              "Login",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Center(
                            child: Text("login to continue using the app",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.black26)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //  Login form is Starting here
                          Text(
                            "Email",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            cursorColor: Theme.of(context).primaryColor,
                            onFieldSubmitted: (value) {
                              Utils.changeFocusNext(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                            textCapitalization: TextCapitalization.words,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: const InputDecoration(
                              hintText: "Enter your email",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Password",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            cursorColor: Theme.of(context).primaryColor,
                            onFieldSubmitted: (value) {
                              Utils.changeFocusNext(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                            obscureText: isVisible,
                            obscuringCharacter: "*",
                            style: (isVisible)
                                ? Theme.of(context).textTheme.bodyLarge
                                : Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              suffixIcon: (isVisible)
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = false;
                                        });
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.eye_slash,
                                        color: Colors.black26,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = true;
                                        });
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.eye,
                                        color: Colors.black26,
                                      )),
                              hintText: "Enter your password",
                            ),
                          ),

                          //  Login form is ending here
                          const SizedBox(
                            height: 6,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, RouteNames.forgetPassword),
                                child: Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.end,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w800),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //  Login Button
                          ElevatedButton(
                            onPressed: () {
                              if (emailController.text == "") {
                                Utils.flushBarErrorMessage(
                                    "Please Enter Email", context);
                              } else if (passwordController.text == "") {
                                Utils.flushBarErrorMessage(
                                    "Please Enter Password", context);
                              } else if (passwordController.text.length < 4) {
                                Utils.flushBarErrorMessage(
                                    "Password must be at least 4 character",
                                    context);
                              } else {
                                passwordFocusNode.unfocus();
                                Map data = {
                                  "email": emailController.text.trim(),
                                  "password": passwordController.text.trim()
                                };
                                provider.loginApi(data, context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 60.0),
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Text("Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Facebook, Google, and Apple icon button is here
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                const Flexible(
                                    child: Divider(
                                  thickness: 1.0,
                                )),
                                Text(
                                  "  or login with  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black38),
                                ),
                                const Flexible(
                                    child: Divider(
                                  thickness: 1.0,
                                )),
                              ],
                            ),
                          ),
                          // Flexible(fit: FlexFit.tight, child: Container()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    onPressed: () {},
                                    child: Image.asset(
                                      "assets/images/icons8-facebook-48.png",
                                      height: 60,
                                      width: 60,
                                    )),
                              ),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    onPressed: () {},
                                    child: Image.asset(
                                      "assets/images/icons8-google-48.png",
                                      height: 60,
                                      width: 60,
                                    )),
                              ),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    onPressed: () {},
                                    child: Image.asset(
                                      "assets/images/icons8-apple-logo-64.png",
                                      height: 60,
                                      width: 60,
                                    )),
                              )
                            ],
                          ),
                          // Flexible(child: Container()),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              TextButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, RouteNames.register),
                                  child: Text("Register",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)))
                            ],
                          )
                        ]),
                  ),
                ),
              ),
      );
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
