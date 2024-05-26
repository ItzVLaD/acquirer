import 'package:acquirer/common/widgets/shimmer.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Custom class with CategoryCartShimmer widget
class CategoryCartShimmer extends StatelessWidget {
  const CategoryCartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShimmerEffect(width: TSizes.iconLg, height: TSizes.iconLg, radius: 100),
        SizedBox(width: TSizes.xs),
        ShimmerEffect(width: 160, height: 24, radius: 8),
      ],
    );
  }
}
