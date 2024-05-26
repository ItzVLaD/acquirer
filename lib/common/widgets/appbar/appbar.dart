import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Class with custom AppBar widget
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.additionalContent,
    this.color = TColors.primary,
    this.arrowColor = TColors.white,
    this.verticalPadding = TSizes.sm,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Widget? additionalContent;
  final Color? color;
  final Color? arrowColor;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: TSizes.spaceDefault,
          vertical: verticalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              leading: showBackArrow
                  ? IconButton(
                      padding: const EdgeInsets.only(right: TSizes.xs),
                      onPressed: leadingOnPressed ?? () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: arrowColor,
                        size: TSizes.iconMd,
                      ),
                    )
                  : leadingIcon != null
                      ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                      : null,
              title: title,
              actions: actions,
              titleSpacing: 0,
              leadingWidth: TSizes.iconMd + TSizes.xs,
            ),
            Container(child: additionalContent),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
