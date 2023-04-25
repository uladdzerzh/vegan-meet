import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  // Pick an image from the specified source
  Future<File?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Error while picking image: $e');
    }
    return null;
  }

  // Pick an image from gallery
  Future<File?> pickImageFromGallery() async {
    return await pickImage(source: ImageSource.gallery);
  }

  // Pick an image using camera
  Future<File?> pickImageFromCamera() async {
    return await pickImage(source: ImageSource.camera);
  }
}
