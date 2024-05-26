import "package:acquirer/utils/constants/sizes.dart";
import "package:flutter/material.dart";

/// Class with spacing styles
class SpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.appBarHeight,
    left: TSizes.spaceDefault,
    right: TSizes.spaceDefault,
    bottom: TSizes.spaceDefault,
  );
}
