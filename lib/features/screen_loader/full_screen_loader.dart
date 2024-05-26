import 'package:acquirer/features/screen_loader/widgets/animation_loader_widget.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with Full Screen Loader
class FullScreenLoader {
  /// Method to call open Loading Dialog
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              AnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  /// Method to hide Loading Dialog
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
