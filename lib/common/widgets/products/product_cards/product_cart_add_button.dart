import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/authentication/controllers/login_controller.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with ProductCartAddToCartButton widget
class ProductCartAddToCartButton extends StatelessWidget {
  const ProductCartAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final guest = AuthenticationRepository.instance.authUser == null;
    final cartController = guest ? null : UserController.instance;

    return InkWell(
      hoverColor: TColors.primary.withOpacity(0),
      onTap: () {
        if (!guest) {
          cartController!.addOneToCart(product.id);
        } else {
          Get.defaultDialog(
            title: 'Unregistered User',
            middleText: 'You need to login',
            onConfirm: () {
              LoginController.instance.googleSignIn();
            },
            onCancel: () => () => Get.back(),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: TColors.primary.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusSm),
            bottomRight: Radius.circular(TSizes.productImageRadius),
          ),
        ),
        child: SizedBox(
          height: TSizes.iconLg,
          width: TSizes.iconLg,
          child: Center(
            child: !guest
                ? Obx(() {
                    final productQuantityInCart = cartController!.getProductQuantityInCart(product.id);
                    return productQuantityInCart > 0
                        ? Text(
                            productQuantityInCart.toString(),
                            style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
                          )
                        : const Icon(Icons.add, color: TColors.white);
                  })
                : const Icon(Icons.add, color: TColors.white),
          ),
        ),
      ),
    );
  }
}
