import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommonFunctions {
  void showMessageSnackBar(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  String extractLast10Digits(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length >= 10) {
      return digitsOnly.substring(digitsOnly.length - 10);
    } else {
      return digitsOnly;
    }
  }

  Future<XFile?> getImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 100);
    return image;
  }
}
