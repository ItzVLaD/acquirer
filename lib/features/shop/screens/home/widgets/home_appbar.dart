import 'package:acquirer/common/widgets/appbar/appbar.dart';
import 'package:acquirer/common/widgets/appbar/appbar_tab.dart';
import 'package:acquirer/common/widgets/icons/icon_get_to_cart.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/screens/admin/admin.dart';
import 'package:acquirer/features/shop/screens/settings/settings_icon.dart';
import 'package:acquirer/features/shop/screens/wishlist/wishlist.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with HomeAppBar widget
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;

    return MyAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.white)),
              Text(TTexts.appName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
            ],
          ),
          Row(
            children: [
              Obx(
                () => userController.user.value.isAdmin
                    ? AppBarTab(
                        title: 'Admin Panel',
                        onPressed: () => Get.to(
                          () => const AdminScreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        ),
                      )
                    : const SizedBox(),
              ),
              const AppBarTab(title: 'Products', isActive: true),
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
