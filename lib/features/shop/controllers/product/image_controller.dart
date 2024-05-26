import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:get/get.dart';

/// Class with a controller for ProductImage
class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  ///Variables
  RxString selectedProductImage = ''.obs;

  /// Get All Images from product
  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};
    images.add(product.thumbnail);
    selectedProductImage.value = product.thumbnail;

    if (product.images != null) {
      images.addAll(product.images!);
    }

    return images.toList();
  }
}
