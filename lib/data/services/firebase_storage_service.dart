import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Class with service for FirebaseStorage
class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  /// Upload Local Assets from IDE, returns a Uint8List containing image data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return imageData;
  }

  /// Upload image using ImageData on Cloud Firebase Storage
  /// Returns the downloadURL of the uploaded image
  Future<String> uploadImageData(String path, Uint8List image, String name) async {
    final ref = _firebaseStorage.ref(path).child(name);
    await ref.putData(image);
    final url = await ref.getDownloadURL();
    return url;
  }

  /// Upload image on Cloud Firebase Storage
  /// Returns the download URL of the uploaded image
  Future<String> uploadImageFile(String path, XFile image) async {
    final ref = _firebaseStorage.ref(path).child(image.name);
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;
  }
}
