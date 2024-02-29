import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class ImageCropService {
  Future<File?> cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 50,
        maxHeight: 800,
        maxWidth: 800,
        compressFormat: ImageCompressFormat.jpg,
        cropStyle: CropStyle.circle);

    // Convert CroppedFile to File
    if (croppedFile != null) {
      return File(croppedFile.path);
    }

    return null;
  }
}
