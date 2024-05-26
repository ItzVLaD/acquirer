import 'package:acquirer/features/authentication/controllers/login_controller.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Unregistered extends StatelessWidget {
  const Unregistered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.account_circle,
          color: TColors.black,
          size: TSizes.iconLg,
        ),
        const SizedBox(width: TSizes.xs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unregistered User',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            InkWell(
              onTap: () {
                controller.googleSignIn();
              },
              child: Text(
                'Login',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ).copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: TColors.backgroundDark),
              ),
            )
          ],
        ),
      ],
    );
  }
}
