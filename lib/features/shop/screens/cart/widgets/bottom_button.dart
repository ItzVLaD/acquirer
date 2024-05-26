import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with BottomButton widget
class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceDefault, vertical: TSizes.xs),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: TColors.grey, width: 1))),
      child: Row(
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  ),
                ),
              ),
              onPressed: () {
                controller.clearCart();
                Get.back();
              },
              child: Obx(
                () => Text(
                  'Checkout \$${controller.totalCartPrice.value.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall!.apply(color: TColors.white),
                ),
              ),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
