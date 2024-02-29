import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NetworkImageWithErrorHandling extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final double? radius;
  final bool? isCircle;

  const NetworkImageWithErrorHandling(
      {super.key,
      required this.imageUrl,
      this.height,
      this.radius,
      this.width,
      this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    log("image Url: $imageUrl");
    Key imageKey = UniqueKey();
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0.0),
      child: SizedBox(
        height: height ?? 160.0,
        width: width ?? double.maxFinite,
        child: (imageUrl == null || imageUrl == "null")
            ? LottieBuilder.asset("assets/animations/404NotFound.json")
            : (isCircle == true)
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      height: 200.0,
                      fit: BoxFit.cover,
                      key: imageKey,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 48.0,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Failed to load image',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Image.network(
                    imageUrl!,
                    height: 200.0,
                    fit: BoxFit.cover,
                    key: imageKey,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 44.0,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Failed to load image',
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}
