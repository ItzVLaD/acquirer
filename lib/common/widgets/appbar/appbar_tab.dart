import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppBarTab extends StatelessWidget {
  const AppBarTab({
    super.key,
    required this.title,
    this.onPressed,
    this.isActive = false,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(TSizes.sm),
        child: MouseRegion(
          cursor: isActive ? MouseCursor.defer : SystemMouseCursors.click,
          child: Text(
            title,
            style: isActive
                ? Theme.of(context).textTheme.titleMedium!.apply(color: TColors.white)
                : Theme.of(context).textTheme.titleLarge!.apply(color: TColors.white),
          ),
        ),
      ),
    );
  }
}
