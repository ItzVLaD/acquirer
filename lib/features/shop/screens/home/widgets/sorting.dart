import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Custom class with SortingWidget
class SortingWidget extends StatefulWidget {
  const SortingWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SortingWidgetState createState() => _SortingWidgetState();
}

class _SortingWidgetState extends State<SortingWidget> {
  String _selectedSortingOption = 'Price';
  bool _isAscending = false;

  final controller = ProductController.instance;
  final List<String> _sortingOptions = ['Rating', 'Price', 'Popularity'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _showSortingOptions(context);
          },
          child: Text(
            _selectedSortingOption,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(width: TSizes.xxs),
        GestureDetector(
          onTap: () {
            setState(() {
              _isAscending = !_isAscending;
              controller.setSelected(controller.selectedProducts.reversed.toList());
            });
          },
          child: Icon(
            _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
            size: TSizes.iconMd,
            color: TColors.darkGrey,
          ),
        ),
      ],
    );
  }

  void _showSortingOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _sortingOptions.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(_sortingOptions[index], style: Theme.of(context).textTheme.bodyMedium),
              onTap: () {
                setState(() {
                  index == 0
                      ? controller.sortByRating(desc: !_isAscending)
                      : index == 1
                          ? controller.sortByPrice(desc: !_isAscending)
                          : controller.sortByReviews(desc: !_isAscending);
                  _selectedSortingOption = _sortingOptions[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
