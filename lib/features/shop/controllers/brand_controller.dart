import 'package:acquirer/data/repositories/brands/brand_repository.dart';
import 'package:acquirer/features/shop/models/brand_model.dart';
import 'package:acquirer/utils/helpers/dummy_data.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Class with a controller for BrandModel
class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  /// Variables
  final isLoading = false.obs;
  final _brandRepository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  /// Load Brand data
  Future<void> fetchBrands() async {
    try {
      isLoading.value = true;

      final brands = await _brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      allBrands.sort((a, b) => a.name.compareTo(b.name));
    } finally {
      isLoading.value = false;
    }
  }

  /// Upload brand data from assets
  Future<void> uploadData() async {
    await _brandRepository.uploadDummyData(DummyData.brands);
  }

  Future<void> uploadBrand(BrandModel brand, Uint8List? image) async {
    await _brandRepository.uploadSingleBrand(brand, image);
  }

  String getBrandName(String id) {
    try {
      return allBrands.firstWhere((brand) => brand.id == id).name;
    } catch (e) {
      return '';
    }
  }
}
