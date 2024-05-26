import 'package:acquirer/data/repositories/categories/category_repository.dart';
import 'package:acquirer/features/shop/models/category_model.dart';
import 'package:acquirer/utils/helpers/dummy_data.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Class with a controller for CategoryModel
class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Load category data
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      allCategories.sort((a, b) => a.name.compareTo(b.name));

      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).toList());
    } finally {
      isLoading.value = false;
    }
  }

  /// Upload category data from assets
  Future<void> uploadData() async {
    await _categoryRepository.uploadDummyData(DummyData.categories);
  }

  Future<void> uploadCategory(CategoryModel category, Uint8List? image) async {
    await _categoryRepository.uploadSingleCategory(category, image);
  }
}
