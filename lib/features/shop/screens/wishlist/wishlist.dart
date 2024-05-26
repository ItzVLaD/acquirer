import 'package:acquirer/common/widgets/layouts/grid_layout.dart';
import 'package:acquirer/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/screens/product_details/product_details.dart';
import 'package:acquirer/features/shop/screens/wishlist/widgets/wishlist_appbar.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with WishScreen frontend
class WishScreen extends StatelessWidget {
  const WishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WishAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: TSizes.md, horizontal: TSizes.spaceDefault),
              child: Obx(
                () => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
                    final products = snapshot.data;
                    if (products == null || products.isEmpty) {
                      return Center(
                        child: Text(
                          'Your wishlist is empty :(',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    }
                    return GridLayout(
                      itemCount: products.length,
                      crossAxisCount: (DeviceUtils.getScreenWidth(context) / 190).floor(),
                      itemBuilder: (_, index) => ProductCardVertical(
                        product: products[index],
                        onPressed: () => Get.to(() => ProductDetails(product: products[index])),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
