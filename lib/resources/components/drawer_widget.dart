import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/routes/routes_names.dart';

class MyDrawer extends StatelessWidget {
  final String? imageUrl;

  const MyDrawer({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          maxWidth: 230.0,
        ),
        child: Column(
          // shrinkWrap: true,
          mainAxisSize: MainAxisSize.min,
          children: [
            DrawerHeader(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: (imageUrl != null)
                      ? Image.network(imageUrl!)
                      : const Icon(CupertinoIcons.person_alt),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text("name")
              ],
            )),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RouteNames.userProfileView);
                },
                child: Text(
                  "Profile",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Country",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Contact Us",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
            TextButton(onPressed: () {}, child: const Text("Logout")),
            Flexible(child: Container()),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w300, color: Colors.black26),
                    text: "all copyrights reserve © 2023",
                    children: [
                      TextSpan(
                        text: " AadityaAppDev",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      )
                    ])),
           
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
