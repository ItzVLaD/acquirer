import 'package:acquirer/common/widgets/appbar/appbar.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/screens/cart/widgets/bottom_button.dart';
import 'package:acquirer/features/shop/screens/cart/widgets/product_cart_horizontal.dart';
import 'package:acquirer/features/shop/screens/product_details/product_details.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with CartScreen frontend
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.updateCartTotals();

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        arrowColor: TColors.black,
        color: null,
        verticalPadding: 0,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: const BottomButton(),
      body: Row(
        children: [
          const Expanded(flex: 0, child: SizedBox()),
          Expanded(
            flex: 4,
            child: Obx(() {
              return controller.user.value.cart.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.spaceDefault,
                          vertical: TSizes.md,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.user.value.cart.length,
                          separatorBuilder: (_, __) => const SizedBox(height: TSizes.xl),
                          itemBuilder: (_, index) => ProductCartHorizontal(
                            onPressed: () => Get.to(() => ProductDetails(
                                  showFooter: false,
                                  product: ProductController.instance.allProducts
                                      .firstWhere((product) => product.id == controller.user.value.cart.keys.toList()[index]),
                                )),
                            productId: controller.user.value.cart.keys.toList()[index],
                            quantity: controller.getProductQuantityInCart(controller.user.value.cart.keys.toList()[index]),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                      'Your Cart is Empty :(',
                      style: Theme.of(context).textTheme.titleLarge,
                    ));
            }),
          ),
          const Expanded(flex: 0, child: SizedBox()),
        ],
      ),
    );
  }
}
