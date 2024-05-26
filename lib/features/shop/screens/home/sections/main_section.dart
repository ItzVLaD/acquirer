import 'package:acquirer/common/widgets/layouts/grid_layout.dart';
import 'package:acquirer/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/screens/product_details/product_details.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/constants/text_strings.dart';
import 'package:acquirer/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainSection extends StatelessWidget {
  const MainSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final guest = AuthenticationRepository.instance.authUser == null;
    final productController = Get.put(ProductController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Text(UserController.instance.user.value.cart['00006'].toString()),
        //ElevatedButton(onPressed: () => controller.uploadData(), child: const Text('Upload')),
        Text(TTexts.popularProducts, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: TSizes.md),
        Obx(() {
          if (productController.allProducts.isEmpty) {
            return const Center(child: Text('No data found'));
          }
          return GridLayout(
            itemCount: productController.allProducts.length,
            crossAxisCount: (DeviceUtils.getScreenWidth(context) / 7 * 6 / 190).floor(),
            itemBuilder: (_, index) => ProductCardVertical(
              onPressed: () => Get.to(() => ProductDetails(
                    product: productController.allProducts[index],
                    showFooter: !guest,
                  )),
              product: productController.allProducts[index],
            ),
          );
        }),
      ],
    );
  }
}
