import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerMethod {
  Future<String> getImage(ImageSource imgSource) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImg = await picker.pickImage(source: imgSource);
    if (pickedImg != null) {
      final CroppedFile? croppedImg = await ImageCropper().cropImage(
          sourcePath: pickedImg.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.jpg,
          maxHeight: 512,
          maxWidth: 512,
          compressQuality: 100,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "Crop Image",
              toolbarColor: Get.theme.appBarTheme.backgroundColor,
              // toolbarWidgetColor: ColorConstants.kWhite,
              backgroundColor: Colors.black,
              activeControlsWidgetColor: Colors.red,
              // initAspectRatio: CropAspectRatioPreset.original,
              cropFrameColor: Colors.white,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ]);
      if (croppedImg != null) {
        return croppedImg.path;
      } else {
        return "";
      }
    } else {
      return "";
    }
  }
}
