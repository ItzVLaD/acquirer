import 'package:acquirer/data/repositories/authentication/authentication_repository.dart';
import 'package:acquirer/features/authentication/controllers/login_controller.dart';
import 'package:acquirer/features/shop/screens/cart/cart_popup.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Class with IconButton widget
IconButton iconGetToCart() {
  final guest = AuthenticationRepository.instance.authUser == null;
  return IconButton(
    onPressed: () {
      if (guest) {
        Get.defaultDialog(
          title: 'Unregistered User',
          middleText: 'You need to login',
          onConfirm: () {
            LoginController.instance.googleSignIn();
          },
          onCancel: () => () => Get.back(),
        );
      } else {
        //Get.to(() => const CartScreen());
        showCartPopup();
      }
    },
    icon: const Icon(
      Icons.shopping_cart,
      color: TColors.white,
    ),
  );
}
