import 'package:acquirer/features/shop/controllers/brand_controller.dart';
import 'package:acquirer/features/shop/controllers/category_controller.dart';
import 'package:acquirer/features/shop/controllers/homescreen_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:acquirer/features/shop/screens/home/widgets/category_cart_horizontal.dart';
import 'package:acquirer/features/shop/screens/home/widgets/category_cart_shimmer.dart';
import 'package:acquirer/features/shop/screens/home/widgets/search_container.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with HomeScreen frontend
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final categoryController = CategoryController.instance;
    final brandController = BrandController.instance;
    final screenController = Get.put(HomeScreenController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBar(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: TSizes.md, bottom: TSizes.md, left: TSizes.spaceDefault),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //ElevatedButton(onPressed: () => brandController.uploadData(), child: const Text('Upload Brand')),
                          //ElevatedButton(onPressed: () => categoryController.uploadData(), child: const Text('Upload Category')),
                          Text(
                            'Categories',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: TSizes.md),
                          Obx(() {
                            return ListView.separated(
                                itemCount: categoryController.allCategories.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                separatorBuilder: (_, __) => const SizedBox(height: TSizes.sm),
                                itemBuilder: (_, index) {
                                  final category = categoryController.allCategories[index];
                                  return categoryController.isLoading.value
                                      ? const CategoryCartShimmer()
                                      : CategoryCartHorizontal(
                                          categoryName: category.name,
                                          imageUrl: category.image,
                                          onPressed: () {
                                            productController.setSelected(
                                                productController.allProducts.where((p0) => p0.categoryId == category.id).toList());
                                            productController.sortByReviews(desc: true);
                                            HomeScreenController.instance.showCategorySection(category.name);
                                          },
                                        );
                                });
                          }),
                          const SizedBox(height: TSizes.md),
                          Text('Brands', style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(height: TSizes.md),
                          Obx(() {
                            return ListView.separated(
                                itemCount: brandController.allBrands.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                separatorBuilder: (_, __) => const SizedBox(height: TSizes.sm),
                                itemBuilder: (_, index) {
                                  final brand = brandController.allBrands[index];
                                  return brandController.isLoading.value
                                      ? const CategoryCartShimmer()
                                      : CategoryCartHorizontal(
                                          categoryName: brandController.allBrands[index].name,
                                          imageUrl: brandController.allBrands[index].image,
                                          isNetworkImage: true,
                                          onPressed: () {
                                            productController
                                                .setSelected(productController.allProducts.where((p0) => p0.brandId == brand.id).toList());
                                            productController.sortByReviews(desc: true);
                                            HomeScreenController.instance.showCategorySection(brandController.allBrands[index].name);
                                          },
                                        );
                                });
                          }),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: TSizes.md, horizontal: TSizes.spaceDefault),
                    child: Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: TSizes.xxs),
                          const SearchContainer(),
                          const SizedBox(height: TSizes.md),
                          screenController.getActiveSection(),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
