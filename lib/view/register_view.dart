import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../resources/components/custom_back_button.dart';
import '../utils/utils.dart';

class UserRegisterView extends StatefulWidget {
  const UserRegisterView({super.key});

  @override
  State<UserRegisterView> createState() => _UserRegisterViewState();
}

class _UserRegisterViewState extends State<UserRegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (_) => AuthViewModel(),
      child: Consumer<AuthViewModel>(builder: (context, provider, child) {
        return Scaffold(
          body: provider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                                width: 40,
                                child: CustomBackButton(),
                              ),

                              Center(
                                child: CircleAvatar(
                                    backgroundColor: const Color(0xffCC04E6)
                                        .withOpacity(0.1),
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
                                height: 10,
                              ),
                              Center(
                                child: Text("Register",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ),
                              Center(
                                child: Text(
                                  "Enter your personal information. Don't worry, your data is safe",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black26),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),

                              //  Register form is Starting here
                              Text(
                                "Username",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 18.0),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                controller: nameController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffF6F7F9),
                                    focusColor: Theme.of(context).primaryColor,
                                    hintText: "Enter your name",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black26),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColor, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .black12, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                textCapitalization: TextCapitalization.words,
                                controller: emailController,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xffF6F7F9),
                                    focusColor: Theme.of(context).primaryColor,
                                    hintText: "Enter your email",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black26),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColor, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .black12, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    )),
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
                                obscureText: provider.isPasswordVisibla,
                                obscuringCharacter: "*",
                                style: (provider.isPasswordVisibla)
                                    ? Theme.of(context).textTheme.bodyLarge
                                    : Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                    focusColor: Theme.of(context).primaryColor,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          provider.isPasswordVisibla =
                                              !provider.isPasswordVisibla;
                                        },
                                        icon: (provider.isPasswordVisibla)
                                            ? const Icon(
                                                CupertinoIcons.eye_slash,
                                                color: Colors.black26,
                                              )
                                            : const Icon(
                                                CupertinoIcons.eye,
                                                color: Colors.black26,
                                              )),
                                    filled: true,
                                    fillColor: const Color(0xffF6F7F9),
                                    hintText: "Enter your password",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black26),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColor, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .black12, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Confirm Password",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 18.0),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              TextFormField(
                                controller: confirmPasswordController,
                                obscureText: provider.isConfirmPasswordVisibla,
                                obscuringCharacter: "*",
                                style: (provider.isConfirmPasswordVisibla)
                                    ? Theme.of(context).textTheme.bodyLarge
                                    : Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                    focusColor: Theme.of(context).primaryColor,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          provider.isConfirmPasswordVisibla =
                                              !provider
                                                  .isConfirmPasswordVisibla;
                                        },
                                        icon:
                                            (provider.isConfirmPasswordVisibla)
                                                ? const Icon(
                                                    CupertinoIcons.eye_slash,
                                                    color: Colors.black26,
                                                  )
                                                : const Icon(
                                                    CupertinoIcons.eye,
                                                    color: Colors.black26,
                                                  )),
                                    filled: true,
                                    fillColor: const Color(0xffF6F7F9),
                                    hintText: "Enter confirm password",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.black26),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .primaryColor, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors
                                            .black12, // Set the border color
                                        width: 2.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      gapPadding: 8.0,
                                    )),
                              ),

                              //  Register form is ending here
                              const SizedBox(
                                height: 40,
                              ),

                              //  Register Button
                              ElevatedButton(
                                onPressed: () {
                                  if (nameController.text == "") {
                                    Utils.flushBarErrorMessage(
                                        "Please Enter Username", context);
                                  } else if (emailController.text == "") {
                                    Utils.flushBarErrorMessage(
                                        "Please Enter Email", context);
                                  } else if (passwordController.text == "") {
                                    Utils.flushBarErrorMessage(
                                        "Please Enter Password", context);
                                  } else if (passwordController.text.length <
                                      4) {
                                    Utils.flushBarErrorMessage(
                                        "Password must be at least 4 character",
                                        context);
                                  } else if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    Utils.flushBarErrorMessage(
                                        "Confirm Password does not match",
                                        context);
                                  } else {
                                    // passwordFocusNode.unfocus();
                                    Map data = {
                                      "email": emailController.text.trim(),
                                      "password":
                                          passwordController.text.trim(),
                                      "name": nameController.text.trim()
                                    };
                                    provider.registerApi(data, context);
                                  }

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const HomePage()));
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width, 60.0),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                child: Text("Register",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
