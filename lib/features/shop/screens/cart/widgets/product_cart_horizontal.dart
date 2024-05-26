import 'package:acquirer/common/widgets/icons/circular_icon.dart';
import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/controllers/brand_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Class with ProductCartHorizontal widget
class ProductCartHorizontal extends StatelessWidget {
  const ProductCartHorizontal({
    super.key,
    this.onPressed,
    required this.productId,
    required this.quantity,
  });

  final VoidCallback? onPressed;
  final String productId;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final product = ProductController.instance.getProductsById([productId])[0];
    final brand = BrandController.instance.allBrands.firstWhere((brand) => brand.id == product.brandId).name;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: TColors.white.withOpacity(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundedImage(
              imageUrl: product.thumbnail,
              isNetworkImage: true,
              height: 84,
              width: 120,
              padding: const EdgeInsets.all(TSizes.xxs * 2),
              backgroundColor: TColors.backgroundLight,
            ),
            const SizedBox(width: TSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    brand,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: TSizes.xxs * 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularIcon(
                            icon: Icons.remove,
                            width: TSizes.xl,
                            height: TSizes.xl,
                            size: TSizes.sm,
                            color: TColors.black,
                            backgroundColor: TColors.backgroundLight,
                            onPressed: () => UserController.instance.removeOneFromCart(productId),
                          ),
                          const SizedBox(width: TSizes.xs),
                          SizedBox(
                            height: TSizes.lg,
                            width: TSizes.lg,
                            child: Center(
                              child: Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
                            ),
                          ),
                          const SizedBox(width: TSizes.xs),
                          CircularIcon(
                            icon: Icons.add,
                            width: TSizes.xl,
                            height: TSizes.xl,
                            size: TSizes.sm,
                            color: TColors.white,
                            backgroundColor: TColors.primary,
                            onPressed: () => UserController.instance.addOneToCart(productId),
                          ),
                        ],
                      ),
                      Text('\$${(product.price * quantity).toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
