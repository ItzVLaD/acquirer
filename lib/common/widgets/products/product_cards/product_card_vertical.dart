import 'package:acquirer/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:acquirer/common/widgets/products/product_cards/product_cart_add_button.dart';
import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/shop/controllers/brand_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with ProductCardVertical widget
class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    this.onPressed,
    required this.product,
  });

  final VoidCallback? onPressed;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: TColors.white,
          boxShadow: [
            BoxShadow(
              color: TColors.darkGrey.withOpacity(0.15),
              blurRadius: 50,
              spreadRadius: 7,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: TSizes.xs,
                left: TSizes.xs,
                right: TSizes.xs,
              ),
              child: RoundedContainer(
                padding: const EdgeInsets.all(TSizes.xs),
                backgroundColor: TColors.backgroundLight,
                height: 156,
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(child: RoundedImage(imageUrl: product.thumbnail, isNetworkImage: true)),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: AuthenticationRepository.instance.authUser != null ? FavouriteIcon(productId: product.id) : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.sm / 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: TSizes.xxs),
                  Obx(
                    () => Text(
                      BrandController.instance.getBrandName(product.brandId ?? ''),
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  ProductCartAddToCartButton(product: product),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
