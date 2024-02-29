import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/components/custom_back_button.dart';
import '../../utils/routes/routes_names.dart';
import '../../utils/utils.dart';
import '../../view_model/user_profile_view_model.dart';
import '../../view_model/user_view_model.dart';
import 'user_profile_image_widget.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<UserProfileViewModel>(
    //   context,
    // );
    final userPrefences = Provider.of<UserViewModel>(context, listen: false);

    return RefreshIndicator(
        onRefresh: () => userPrefences.getUser(),
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: Consumer<UserProfileViewModel>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leadingWidth: 60,
                leading: const SizedBox(
                  height: 40,
                  width: 60,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      CustomBackButton(),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    UserProfileImageWidget(
                      imageUrl: provider.getProfile.toString(),
                      radius: 80.0,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      provider.getName ?? "User name",
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      provider.getEmail ?? "user@user.com",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(120, 44),
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Text(
                        "Edit Profile",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      thickness: 1.3,
                      color: Colors.black12.withOpacity(0.1),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteNames.home);
                      },
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(
                          CupertinoIcons.home,
                          size: 20,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      title: const Text("Home"),
                      trailing: const Icon(
                        CupertinoIcons.right_chevron,
                        size: 16,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(
                          CupertinoIcons.info,
                          size: 20,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      title: const Text("Information"),
                      trailing: const Icon(
                        CupertinoIcons.right_chevron,
                        size: 16,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Utils.showPopupDailog(context, () {
                          userPrefences.removeData().then((value) {
                            Utils.toastMessage("Logout Successful");
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacementNamed(
                                context, RouteNames.login);
                          }).onError((error, stackTrace) {
                            Utils.flushBarErrorMessage(
                                error.toString(), context);
                          });
                        });
                      },
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(
                          CupertinoIcons.power,
                          size: 20,
                          color: Colors.purpleAccent,
                        ),
                      ),
                      title: const Text("Logout"),
                      trailing: const Icon(
                        CupertinoIcons.right_chevron,
                        size: 16,
                      ),
                    ),
                    Flexible(flex: 3, child: Container()),
                  ],
                ),
              ),
            );
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProfileViewModel>(context, listen: false);

    provider.currentUserData();
  }
}
