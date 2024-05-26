import 'package:flutter/material.dart';

/// Class with ProductTitleText widget
class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
