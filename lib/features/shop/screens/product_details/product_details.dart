import 'package:acquirer/common/widgets/appbar/appbar.dart';
import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/features/shop/screens/product_details/widgets/bottom_add.dart';
import 'package:acquirer/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Class with ProductDetails frontend
class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.product,
    this.showFooter = true,
  });

  final ProductModel product;
  final bool showFooter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: showFooter ? BottomAddToCart(product: product) : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: TColors.backgroundLight,
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.spaceDefault),
                      child: Center(
                        child: RoundedImage(
                          imageUrl: product.thumbnail,
                          isNetworkImage: true,
                          borderRadius: 0,
                        ),
                      ),
                    ),
                  ),
                  MyAppBar(
                    showBackArrow: true,
                    arrowColor: TColors.darkerGrey,
                    color: null,
                    actions: [AuthenticationRepository.instance.authUser != null ? FavouriteIcon(productId: product.id) : const SizedBox()],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.spaceDefault),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserController.instance.user.value.isAdmin
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: TSizes.xxs),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: 'Id: ', style: Theme.of(context).textTheme.labelLarge),
                                          TextSpan(text: product.id, style: Theme.of(context).textTheme.titleLarge),
                                        ],
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () => ProductController.instance.removeProduct(product),
                                      style: ElevatedButton.styleFrom(),
                                      child: Text('Remove', style: Theme.of(context).textTheme.titleSmall),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        ProductMetaData(product: product),
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
