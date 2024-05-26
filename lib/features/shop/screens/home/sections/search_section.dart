import 'package:acquirer/common/widgets/layouts/grid_layout.dart';
import 'package:acquirer/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/screens/home/widgets/sorting.dart';
import 'package:acquirer/features/shop/screens/product_details/product_details.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final guest = AuthenticationRepository.instance.authUser == null;
    final controller = ProductController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SortingWidget(),
        const SizedBox(height: TSizes.sm),
        Obx(
          () => GridLayout(
            itemCount: controller.selectedProducts.length,
            crossAxisCount: (DeviceUtils.getScreenWidth(context) / 7 * 6 / 190).floor(),
            itemBuilder: (_, index) => ProductCardVertical(
              product: controller.selectedProducts[index],
              onPressed: () => Get.to(() => ProductDetails(
                    product: controller.selectedProducts[index],
                    showFooter: !guest,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
