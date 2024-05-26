import 'package:acquirer/data/services/firebase_storage_service.dart';
import 'package:acquirer/features/shop/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Class with repository of Brand data
class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get all brands
  Future<List<BrandModel>> getAllBrands() async {
    final snapshot = await _db.collection('Brands').get();
    final list = snapshot.docs.map((document) => BrandModel.fromSnapShot(document)).toList();
    return list;
  }

  /// Upload brands to the cloud firebase
  Future<void> uploadDummyData(List<BrandModel> brands) async {
    //Upload all the brands along with their images
    final storage = Get.put(FirebaseStorageService());

    for (var brand in brands) {
      // get imageData link from the local assets
      final file = await storage.getImageDataFromAssets(brand.image);

      // upload image and get its URL
      final url = await storage.uploadImageData('Brands', file, brand.name);

      // Assign URL Brand.image attribute
      brand.image = url;

      // Store Brand in Firestore
      await _db.collection('Brands').doc(brand.id).set(brand.toJson());
    }
  }

  Future<void> uploadSingleBrand(BrandModel brand, Uint8List? image) async {
    if (image != null) {
      final storage = Get.put(FirebaseStorageService());

      final url = await storage.uploadImageData('Brands', image, brand.name);
      brand.image = url;
    }

    // Store Brand in Firestore
    await _db.collection('Brands').doc(brand.id).set(brand.toJson());
  }
}
