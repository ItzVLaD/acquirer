import 'package:acquirer/common/widgets/layouts/grid_layout.dart';
import 'package:acquirer/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/shop/controllers/homescreen_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/screens/home/widgets/sorting.dart';
import 'package:acquirer/features/shop/screens/product_details/product_details.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final guest = AuthenticationRepository.instance.authUser == null;
    final controller = ProductController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => HomeScreenController.instance.showMainSection(),
          child: Container(
            color: TColors.white.withOpacity(0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back_ios_new, color: TColors.black, size: TSizes.iconSm),
                  const SizedBox(width: TSizes.xxs * 2),
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: TSizes.xs),
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
