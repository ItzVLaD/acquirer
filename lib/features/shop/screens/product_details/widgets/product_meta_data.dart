import 'package:acquirer/features/shop/controllers/brand_controller.dart';
import 'package:acquirer/features/shop/controllers/category_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/features/shop/screens/product_details/widgets/product_titile_text.dart';
import 'package:acquirer/features/shop/screens/product_details/widgets/product_value_text.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Class with ProductMetaData widget
class ProductMetaData extends StatelessWidget {
  const ProductMetaData({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final brands = BrandController.instance.allBrands;
    final categories = CategoryController.instance.allCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.xs),
        Text(
          product.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: TSizes.xs),
        const ProductTitleText(text: 'Manufacturer:'),
        ProductValueText(
          text: brands.firstWhere((brand) => brand.id == product.brandId).name,
        ),
        const SizedBox(height: TSizes.xs),
        const ProductTitleText(text: 'Category:'),
        ProductValueText(
          text: categories.firstWhere((category) => category.id == product.categoryId).name,
        ),
        const SizedBox(height: TSizes.xs),
        const ProductTitleText(text: 'Stock:'),
        ProductValueText(text: product.stock != 0 ? 'In Stock' : 'Out of Stock'),
        const SizedBox(height: TSizes.xs),
        const ProductTitleText(text: 'Description:'),
        ProductValueText(textAlign: TextAlign.justify, text: product.description!),
      ],
    );
  }
}
