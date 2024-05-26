import 'package:acquirer/features/shop/screens/home/sections/category_section.dart';
import 'package:acquirer/features/shop/screens/home/sections/main_section.dart';
import 'package:acquirer/features/shop/screens/home/sections/search_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  //Rx<Widget> activeSection = Rx<Widget>(const MainSection());
  RxInt index = 0.obs;
  final sections = [
    const MainSection(),
    const SearchSection(),
    const CategorySection(title: ''),
  ];

  void showMainSection() {
    index.value = 0;
  }

  void showCategorySection(String title) {
    sections[2] = CategorySection(title: title);
    index.value = 0;
    index.value = 2;
  }

  void showSearchSection() {
    index.value = 1;
  }

  Widget getActiveSection() {
    return sections[index.value];
  }
}
