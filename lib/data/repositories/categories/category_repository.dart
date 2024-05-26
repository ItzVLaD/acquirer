import 'package:acquirer/data/services/firebase_storage_service.dart';
import 'package:acquirer/features/shop/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Class with repository of Category data
class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await _db.collection('Categories').get();
    final list = snapshot.docs.map((document) => CategoryModel.fromSnapShot(document)).toList();
    return list;
  }

  /// Upload categories to the cloud firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    //Upload all the categories along withe their images
    final storage = Get.put(FirebaseStorageService());

    for (var category in categories) {
      // get imageData link from the local assets
      final file = await storage.getImageDataFromAssets(category.image);

      // upload image and get its URL
      final url = await storage.uploadImageData('Categories', file, category.name);

      // Assign URL Category.image attribute
      category.image = url;

      // Store Category in Firestore
      await _db.collection('Categories').doc(category.id).set(category.toJson());
    }
  }

  Future<void> uploadSingleCategory(CategoryModel category, Uint8List? image) async {
    if (image != null) {
      final storage = Get.put(FirebaseStorageService());

      final url = await storage.uploadImageData('Categories', image, category.name);
      category.image = url;
    }

    await _db.collection('Categories').doc(category.id).set(category.toJson());
  }
}
