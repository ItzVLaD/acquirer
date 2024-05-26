import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

///Class with CircularIcon widget
class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    this.height,
    this.width,
    this.size = TSizes.lg,
    required this.icon,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final double? height, width, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: onPressed,
      hoverColor: TColors.primary.withOpacity(0),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(TSizes.xxs * 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: backgroundColor != null
                ? backgroundColor!
                : dark
                    ? TColors.black.withOpacity(0.9)
                    : TColors.white.withOpacity(0.9)),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
