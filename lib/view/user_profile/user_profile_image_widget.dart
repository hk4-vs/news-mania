import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/components/custom_back_button.dart';
import '../../view_model/image_view_model.dart';

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget(
      {super.key, required this.imageUrl, this.radius});
  final String? imageUrl;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    log("image url log: $imageUrl");
    return ChangeNotifierProvider<ImageViewModel>(
      create: (context) => ImageViewModel(),
      child: Consumer<ImageViewModel>(
        builder: (context, provider, _) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (imageUrl != null ||
                      imageUrl!.isNotEmpty ||
                      imageUrl != "") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileImage(
                                  imageUrl: imageUrl!,
                                )));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.5)),
                  child: CircleAvatar(
                    foregroundColor: Colors.blue,
                    radius: radius ?? 50.0,
                    child: Hero(
                        tag: "profile-image",
                        child: (imageUrl == null ||
                                imageUrl!.isEmpty ||
                                imageUrl == "null")
                            ? const Icon(CupertinoIcons.person_alt)
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageUrl!),
                                      onError: (exception, stackTrace) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ), // Placeholder color or any other custom design.
                                        child: const Center(
                                          child: FittedBox(
                                            child: Text(
                                              "Failed to load image",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              )),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: InkWell(
                  onTap: () {
                    log('Camera Button Tapped');
                    provider.pickAndCropImage();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      CupertinoIcons.camera,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              )
            ],
          );

          // return Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       if (viewModel.pickedImage != null)
          //         Image.file(viewModel.pickedImage!),
          //       ElevatedButton(
          //         onPressed: () async {
          //           await viewModel.pickAndCropImage();
          //         },
          //         child: Text('Pick & Crop Image'),
          //       ),
          //       ElevatedButton(
          //         onPressed: () async {
          //           await viewModel.uploadImageToServer();
          //         },
          //         child: Text('Upload Image to Server'),
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Row(
          children: [
            SizedBox(
              width: 10,
            ),
            CustomBackButton(),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Hero(tag: "profile-image", child: Image.network(imageUrl)),
      ),
    );
  }
}
