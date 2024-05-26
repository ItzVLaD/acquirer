import 'package:acquirer/features/personalization/controllers/user_controller.dart';
import 'package:acquirer/features/shop/screens/admin/widgets/admin_appbar.dart';
import 'package:acquirer/features/shop/screens/admin/widgets/brand_form.dart';
import 'package:acquirer/features/shop/screens/admin/widgets/category_form.dart';
import 'package:acquirer/features/shop/screens/admin/widgets/product_form.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = UserController.instance.user.value.isAdmin;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminAppBar(),
            isAdmin
                ? const Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: TSizes.spaceDefault, vertical: TSizes.md),
                          child: Column(
                            children: [
                              ProductForm(),
                              SizedBox(height: TSizes.md),
                              CategoryForm(),
                              SizedBox(height: TSizes.md),
                              BrandForm(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  )
                : SizedBox(
                    height: DeviceUtils.getScreenHeight() * 0.9,
                    child: const Center(
                      child: Text('You don\'t have admin rights'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
