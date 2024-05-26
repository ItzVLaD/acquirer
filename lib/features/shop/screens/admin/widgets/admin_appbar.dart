import 'package:acquirer/common/widgets/appbar/appbar.dart';
import 'package:acquirer/common/widgets/appbar/appbar_tab.dart';
import 'package:acquirer/common/widgets/icons/icon_get_to_cart.dart';
import 'package:acquirer/features/shop/screens/home/home.dart';
import 'package:acquirer/features/shop/screens/settings/settings_icon.dart';
import 'package:acquirer/features/shop/screens/wishlist/wishlist.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAppBar extends StatelessWidget {
  const AdminAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Launch it', style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.white)),
              Text(TTexts.appName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
            ],
          ),
          Row(
            children: [
              const AppBarTab(title: 'Admin Panel', isActive: true),
              AppBarTab(
                title: 'Products',
                onPressed: () => Get.to(
                  () => const HomeScreen(),
                  transition: Transition.noTransition,
                  duration: Duration.zero,
                ),
              ),
              AppBarTab(
                title: 'Wishlist',
                onPressed: () => Get.to(
                  () => const WishScreen(),
                  transition: Transition.noTransition,
                  duration: Duration.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        const SizedBox(width: TSizes.xxs * 2),
        iconGetToCart(),
        const SizedBox(width: TSizes.sm),
        const SettingsIcon(),
      ],
    );
  }
}
