import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registered extends StatelessWidget {
  const Registered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.user.value.profilePicture != ''
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
                        color: TColors.lightGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
              const SizedBox(width: TSizes.xs),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user.value.username,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    width: 204,
                    child: Text(
                      controller.user.value.email,
                      style: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: TColors.backgroundDark),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: TSizes.xxs * 2),
          InkWell(
            onTap: () {
              controller.logout();
            },
            child: Text(
              'Logout',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ).copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: TColors.backgroundDark),
            ),
          )
        ],
      ),
    );
  }
}
