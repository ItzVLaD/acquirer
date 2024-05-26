import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/screens/settings/widgets/registered.dart';
import 'package:acquirer/features/shop/screens/settings/widgets/unregistered.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with SettingsScreen frontend
class SettingsIcon extends StatelessWidget {
  const SettingsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final guest = AuthenticationRepository.instance.authUser == null;
    final controller = UserController.instance;

    return PopupMenuButton(
      padding: EdgeInsets.zero,
      surfaceTintColor: TColors.white,
      icon: guest
          ? const Icon(
              Icons.account_circle,
              color: TColors.white,
              size: TSizes.iconLg,
            )
          : Obx(
              () => controller.user.value.profilePicture != ''
                  ? RoundedImage(
                      imageUrl: controller.user.value.profilePicture,
                      isNetworkImage: true,
                      width: TSizes.iconLg,
                      height: TSizes.iconLg,
                      borderRadius: 100,
                      backgroundColor: TColors.primary.withOpacity(0),
                    )
                  : Container(
                      height: TSizes.iconLg,
                      width: TSizes.iconLg,
                      decoration: BoxDecoration(
                        color: TColors.lightGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
            ),
      itemBuilder: (_) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          enabled: false,
          child: guest ? const Unregistered() : const Registered(),
        ),
      ],
    );
  }
}
