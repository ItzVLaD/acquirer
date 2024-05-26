import 'package:acquirer/features/shop/controllers/homescreen_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

/// Custom class with SearchContainer widget
class SearchContainer extends StatefulWidget {
  const SearchContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchContainerState createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  final productController = ProductController.instance;
  final controller = TextEditingController();
  bool _isSearching = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && controller.text == '') {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        color: TColors.white,
      ),
      child: TextField(
        focusNode: _focusNode,
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
            child: InkWell(
              onTap: () {
                _search(controller.text);
              },
              child: Icon(
                Icons.search,
                color: _isSearching ? TColors.black : TColors.darkGrey,
              ),
            ),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        controller.clear();
                        _isSearching = false;
                      });
                      HomeScreenController.instance.showMainSection();
                    },
                    child: const Icon(Icons.clear, color: TColors.black),
                  ),
                )
              : null,
          hintText: _isSearching ? '' : TTexts.searchField,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: TColors.grey),
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: TColors.darkGrey),
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          setState(() {
            if (controller.text != '') _isSearching = true;
          });
        },
        onSubmitted: (value) {
          _search(value);
        },
      ),
    );
  }

  void _search(String input) {
    if (input != '') {
      productController.serchByTitle(input);
      productController.sortByReviews(desc: true);
      HomeScreenController.instance.showSearchSection();
    } else {
      setState(() {
        _isSearching = false;
      });
      HomeScreenController.instance.showMainSection();
    }
  }
}
