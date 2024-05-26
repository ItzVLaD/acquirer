import 'package:acquirer/common/widgets/icons/circular_icon.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with BottomAddToCart widget
class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.updateAlreadyAddedProductCount(product);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceDefault, vertical: TSizes.xs),
      decoration: const BoxDecoration(
        color: TColors.white,
        border: Border(top: BorderSide(color: TColors.grey, width: 1)),
      ),
      child: Row(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircularIcon(
                      icon: Icons.remove,
                      backgroundColor: TColors.darkGrey,
                      height: 40,
                      width: 40,
                      color: TColors.white,
                      onPressed: () {
                        controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1;
                      },
                    ),
                    const SizedBox(width: TSizes.sm),
                    SizedBox(
                      width: TSizes.lg,
                      height: TSizes.lg,
                      child: Center(
                        child: Obx(
                          () => Text(
                            controller.productQuantityInCart.value.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.sm),
                    CircularIcon(
                      icon: Icons.add,
                      backgroundColor: TColors.black,
                      height: 40,
                      width: 40,
                      color: TColors.white,
                      onPressed: () {
                        if (controller.productQuantityInCart.value < product.stock) {
                          controller.productQuantityInCart.value += 1;
                        }
                      },
                    ),
                  ],
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      if (controller.productQuantityInCart.value >= 1) {
                        Get.defaultDialog(
                          title: 'Cart',
                          middleText: 'Product has been added to the cart',
                          onConfirm: () {
                            controller.addToCart(product);
                            Get.back();
                          },
                          onCancel: () => () => Get.back(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: controller.productQuantityInCart.value == 0 ? TColors.darkGrey : TColors.black,
                      side: const BorderSide(color: TColors.black),
                    ),
                    child: const Text(TTexts.addTo),
                  ),
                )
              ],
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
