import 'package:acquirer/data/repositories/products/product_repository.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/helpers/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Class with a controller for ProductModel
class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final _productRepository = Get.put(ProductRepository());
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> selectedProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  /// Load Products data
  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;

      final products = await _productRepository.getAllProducts();
      allProducts.assignAll(products);
    } finally {
      isLoading.value = false;
    }
  }

  /// Upload brand data from assets
  Future<void> uploadData() async {
    await _productRepository.uploadDummyData(DummyData.products);
  }

  Future<void> uploadProduct(ProductModel product, Uint8List? image, String? imageName) async {
    await _productRepository.uploadSingleProduct(product, image, imageName);
  }

  /// Updates selected products
  void setSelected(List<ProductModel> products) {
    selectedProducts.assignAll(products);
  }

  /// Sorts by price
  void sortByPrice({bool desc = false}) {
    selectedProducts.sort((a, b) => a.price.compareTo(b.price));
    if (desc) setSelected(selectedProducts.reversed.toList());
  }

  /// Sorts by rating
  void sortByRating({bool desc = false}) {
    selectedProducts.sort((a, b) => a.rating!.compareTo(b.rating!));
    if (desc) setSelected(selectedProducts.reversed.toList());
  }

  /// Sorts by reviews
  void sortByReviews({bool desc = false}) {
    selectedProducts.sort((a, b) => a.reviews!.compareTo(b.reviews!));
    if (desc) setSelected(selectedProducts.reversed.toList());
  }

  /// Search by UserInput
  void serchByTitle(String input) {
    final inputLowerCase = input.toLowerCase();
    final searchResults = allProducts.where((obj) => obj.title.toLowerCase().contains(inputLowerCase)).toList();
    setSelected(searchResults);
  }

  List<ProductModel> getProductsById(List<String> idList) {
    List<ProductModel> products = [];
    for (String id in idList) {
      products.add(allProducts.firstWhere((element) => element.id == id));
    }
    return products;
  }

  void removeProduct(ProductModel product) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () async {
        UserController user = UserController.instance;
        user.isFavourite(product.id) ? user.toggleFavouriteProduct(product.id) : null;
        user.user.value.cart.remove(product.id);
        user.updateCart();
        allProducts.remove(product);
        bool success = await _productRepository.removeProduct(product.id);
        Get.back();
        Get.back();
        final snackBar = SnackBar(
          content: Center(
              child: Text(
            success ? 'Removed' : 'Error',
            style: const TextStyle().copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: TColors.white),
          )),
          behavior: SnackBarBehavior.floating,
          backgroundColor: success ? TColors.success : TColors.error,
        );
        ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
      },
      onCancel: () => () => Get.back(),
    );
  }
}
