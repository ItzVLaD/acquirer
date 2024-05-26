import 'package:acquirer/bindings/network_manager.dart';
import 'package:acquirer/features/authentication/controllers/login_controller.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/controllers/brand_controller.dart';
import 'package:acquirer/features/shop/controllers/category_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:get/get.dart';

/// Class with some General Bindings
class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(ProductController());
    Get.put(UserController());
    Get.put(BrandController());
    Get.put(CategoryController());
    Get.put(LoginController());
  }
}
