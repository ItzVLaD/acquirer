import 'package:acquirer/bindings/general_binding.dart';
import 'package:acquirer/features/shop/screens/home/home.dart';
import 'package:acquirer/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class with full application
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      //initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => const HomeScreen()),
      //   GetPage(name: '/Wishlist', page: () => const WishScreen()),
      //   GetPage(name: '/AdminPanel', page: () => const AdminScreen()),
      //   GetPage(name: '/Cart', page: () => const CartScreen()),
      // ],
      home: const HomeScreen(),
    );
  }
}
