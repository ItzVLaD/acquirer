import 'package:flutter/material.dart';

/// Class with ProductValueText widget
class ProductValueText extends StatelessWidget {
  const ProductValueText({
    super.key,
    required this.text,
    this.textAlign,
  });

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
