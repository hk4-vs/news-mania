import 'dart:developer';

import 'package:flutter/material.dart';

import '../../utils/routes/routes_names.dart';
import '../../view/saved_news_view.dart';
import 'network_image_widget.dart';

class UsreProfilePopupMenuWidget extends StatelessWidget {
  const UsreProfilePopupMenuWidget(
      {super.key, required this.imageUrl, this.name});
  final String imageUrl;
  final String? name;

  @override
  Widget build(BuildContext context) {
    log("log: $imageUrl");
    return PopupMenuButton(
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl.toString()),
          onBackgroundImageError: (exception, stackTrace) => const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel_outlined)),
              ),
            ),
            PopupMenuItem(
                child: Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NetworkImageWithErrorHandling(
                      imageUrl: imageUrl,
                      isCircle: true,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(name.toString(),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            )),
            PopupMenuItem(
              child: const Text("Profile"),
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.userProfileView),
            ),
            PopupMenuItem(
                child: Text("Saved"),
                onTap: () {
                  // Navigator.pushNamed(context, RouteNames.savedNewsView);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SavedNewsView(
                      context: context,
                    );
                  }));
                }),
            const PopupMenuItem(
              child: Text("Country"),
            ),
            const PopupMenuItem(
              child: Text("Contact Us"),
            ),
            PopupMenuItem(
              child: RichText(
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
            )
          ];
        });
  }
}
