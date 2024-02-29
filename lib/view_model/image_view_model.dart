import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/resources/app_urls.dart';
import 'package:news_app/resources/local_storage_keys.dart';
import 'package:news_app/utils/utils.dart';
import '../data/models/login_model.dart';
import 'services/image_cropping_service.dart';
import 'services/image_picker_service.dart';
import 'user_view_model.dart';

class ImageViewModel extends ChangeNotifier {
  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  final ImagePickerService _imagePickerService = ImagePickerService();
  final ImageCropService _imageCropService = ImageCropService();

  Future<void> pickAndCropImage() async {
    final pickedImage = await _imagePickerService.pickImage();
    if (pickedImage != null) {
      final croppedImage = await _imageCropService.cropImage(pickedImage);
      if (croppedImage != null) {
        _pickedImage = croppedImage;
        Future<LoginModel> getUserData() => UserViewModel().getUser();
        try {
          getUserData().then((value) async {
            var request = http.MultipartRequest(
                'POST', Uri.parse(AppUrls.uploadUserProfile));
            request.files.add(await http.MultipartFile.fromPath(
              'profile_image',
              _pickedImage!.path,
              filename: 'profile_image.jpg',
            ));
            request.headers['Authorization'] = 'Bearer ${value.accessToken}';
            request.headers['Content-Type'] = 'multipart/form-data';

            var response = await request.send();
            if (response.statusCode == 200) {
              final profileImageURL = await response.stream.bytesToString();
              var jsonData = jsonDecode(profileImageURL);
              String profile = jsonData["profile_image"].toString();
              UserViewModel()
                  .updateUserToSaveData(LocalStorageKeys.profileImage, profile);

              log("Response log: $profileImageURL");
              log("Response log::: ${jsonData["profile_image"]}");
              Utils.toastMessage("Image Uploded Successful");
            } else {
              Utils.toastMessage("Image Uploded Faild");
            }
          });
        } catch (e) {
          Utils.toastMessage("Error $e");
        }

        notifyListeners();
      }
    }
  }
}
