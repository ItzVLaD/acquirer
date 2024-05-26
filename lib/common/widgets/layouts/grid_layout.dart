import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Class with GridLayout widget
class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    this.crossAxisCount = 5,
    this.mainAxisExtent = 288,
    this.spacing = TSizes.gridViewSpacing,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int crossAxisCount;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
