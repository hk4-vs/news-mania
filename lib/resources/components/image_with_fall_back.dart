import 'package:flutter/material.dart';

class ImageWithFallback extends StatelessWidget {
  final String imageUrl;

  const ImageWithFallback({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // Image is successfully loaded
          return child;
        } else if (loadingProgress.expectedTotalBytes == null) {
          // Image is still loading, show a placeholder or loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Calculate the progress percentage
          final progress = loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!;

          // Show a placeholder or loading indicator with the progress percentage
          return Center(
            child: CircularProgressIndicator(value: progress),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) {
        // Image failed to load, show the custom error widget
        return _buildErrorWidget();
      },
    );
  }

  Widget _buildErrorWidget() {
    // Customize the error widget to show a custom error message or icon.
    return Container(
      decoration: const BoxDecoration(
          color: Colors.grey,
          shape:
              BoxShape.circle), // Placeholder color or any other custom design.
      child: const Center(
        child: FittedBox(
          child: Text(
            "Failed to load image",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
