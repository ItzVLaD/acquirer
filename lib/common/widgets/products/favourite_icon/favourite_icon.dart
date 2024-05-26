import 'package:acquirer/common/widgets/icons/circular_icon.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with FavouriteIcon widget
class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() {
      return CircularIcon(
        icon: controller.isFavourite(productId) ? Icons.favorite : Icons.favorite_border,
        color: controller.isFavourite(productId) ? TColors.error : null,
        onPressed: () => controller.toggleFavouriteProduct(productId),
      );
    });
  }
}
