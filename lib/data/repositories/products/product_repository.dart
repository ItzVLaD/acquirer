import 'package:acquirer/data/services/firebase_storage_service.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

/// Class with repository of product data
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get all products
  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await _db.collection('Products').get();
    final list = snapshot.docs.map((document) => ProductModel.fromSnapShot(document)).toList();
    return list;
  }

  /// Upload brands to the cloud firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    //Upload all the brands along with their images
    final storage = Get.put(FirebaseStorageService());

    for (var product in products) {
      // get imageData link from the local assets
      final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

      // upload image and get its URL
      final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

      // Assign URL product.thumbnail attribute
      product.thumbnail = url;

      // Product list of images
      if (product.images != null && product.images!.isNotEmpty) {
        List<String> imageUrl = [];
        for (var image in product.images!) {
          // get imageData link from the local assets
          final assetImage = await storage.getImageDataFromAssets(image);

          // upload image and get its URL
          final url = await storage.uploadImageData('Products/Images', assetImage, image);

          // Assign URL
          imageUrl.add(url);
        }
        product.images!.clear();
        product.images!.addAll(imageUrl);
      }

      // Store Products in Firestore
      await _db.collection('Products').doc(product.id).set(product.toJson());
    }
  }

  Future<void> uploadSingleProduct(ProductModel product, Uint8List? image, String? imageName) async {
    if (image != null) {
      final storage = Get.put(FirebaseStorageService());

      // upload image and get its URL
      final url = await storage.uploadImageData(
        'Products/Images',
        image,
        'assets/images/products/$imageName',
      );

      // Assign URL product.thumbnail attribute
      product.thumbnail = url;

      product.images!.clear();
      product.images!.add(url);
    }

    // Store Products in Firestore
    await _db.collection('Products').doc(product.id).set(product.toJson());
  }

  /// Get products based on the query
  Future<List<ProductModel>> getFavouriteProducts(List<String> productsId) async {
    if (productsId.isNotEmpty) {
      final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productsId).get();
      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapShot(querySnapshot)).toList();
    } else {
      return [];
    }
  }

  Future<bool> removeProduct(String id) async {
    try {
      await _db.collection('Products').doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
