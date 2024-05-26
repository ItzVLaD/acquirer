import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Custom class with CategoryCartHorizontal widget
class CategoryCartHorizontal extends StatelessWidget {
  const CategoryCartHorizontal({
    super.key,
    required this.categoryName,
    required this.imageUrl,
    this.isNetworkImage = true,
    this.onPressed,
  });

  final String categoryName;
  final String imageUrl;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(color: TColors.white.withOpacity(0)),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedImage(
                imageUrl: imageUrl,
                isNetworkImage: isNetworkImage,
                width: TSizes.iconLg,
                height: TSizes.iconLg,
                padding: const EdgeInsets.all(TSizes.xxs),
                borderRadius: 100,
                backgroundColor: TColors.primary.withOpacity(0.25),
                //imageRadius: 15,
              ),
              const SizedBox(width: TSizes.xs),
              Text(
                categoryName,
                style: const TextStyle().copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: TColors.backgroundDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
