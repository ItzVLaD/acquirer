import 'package:acquirer/features/shop/screens/cart/cart.dart';
import 'package:acquirer/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCartPopup() {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          width: DeviceUtils.getScreenWidth(context) * 0.5,
          height: DeviceUtils.getScreenHeight() * 0.8,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          clipBehavior: Clip.antiAlias,
          child: const CartScreen(),
        ),
      );
    },
  );
}
