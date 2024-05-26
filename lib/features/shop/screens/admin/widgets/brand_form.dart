import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/features/shop/controllers/brand_controller.dart';
import 'package:acquirer/features/shop/models/brand_model.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/helpers/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BrandForm extends StatefulWidget {
  const BrandForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BrandFormState createState() => _BrandFormState();
}

class _BrandFormState extends State<BrandForm> {
  final tStyle = const TextStyle().copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: TColors.backgroundDark);
  final brandsId = BrandController.instance.allBrands.map<String>((category) => category.id).toList();

  final idController = TextEditingController();
  final nameController = TextEditingController();

  String? imagePath;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceDefault, vertical: TSizes.sm),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: TColors.darkGrey.withOpacity(0.3),
            blurRadius: 50,
            spreadRadius: 7,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Brands',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.sm),
          TextField(
            controller: idController,
            maxLines: 1,
            style: tStyle,
            decoration: InputDecoration(
              hintText: '1...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'Id*',
              labelStyle: tStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            ),
            onChanged: (value) {
              setState(() {
                if (idController.text != '' && brandsId.contains(idController.text)) {
                  final brand = BrandController.instance.allBrands.firstWhere((brand) => brand.id == idController.text);
                  nameController.text = brand.name;

                  imagePath = brand.image;
                  image = null;
                }
              });
            },
          ),
          const SizedBox(height: TSizes.sm),
          TextField(
            controller: nameController,
            maxLines: 1,
            style: tStyle,
            decoration: InputDecoration(
              hintText: 'Sports...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'Title*',
              labelStyle: tStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            ),
          ),
          const SizedBox(height: TSizes.sm),
          Row(
            children: [
              Text('Image*:', style: tStyle),
              const SizedBox(width: TSizes.md),
              InkWell(
                onTap: () async {
                  var result = await MyFilePicker.pickAFile();
                  setState(() {
                    image = result.$1;
                    if (image != null) imagePath = null;
                  });
                },
                child: Container(
                  height: 100,
                  width: 160,
                  decoration: BoxDecoration(
                    color: TColors.backgroundLight,
                    border: Border.all(color: TColors.darkGrey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: TSizes.xxs,
                    horizontal: TSizes.xs,
                  ),
                  child: imagePath != null
                      ? RoundedImage(
                          imageUrl: imagePath!,
                          isNetworkImage: true,
                          borderRadius: 20,
                        )
                      : image == null
                          ? Center(
                              child: Text(
                                'Upload Image',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            )
                          : Image.memory(image!),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => clearFields(),
                child: Text(
                  'Clear',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(),
              ElevatedButton(
                onPressed: () => saveProduct(),
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.titleSmall!.apply(color: TColors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void clearFields() {
    setState(() {
      imagePath = null;
      image = null;
      //idController.text = '';
      nameController.text = '';
    });
  }

  void saveProduct() {
    if (idController.text != '' && nameController.text != '' && (image != null || imagePath != null)) {
      BrandModel brand = BrandModel(
        id: idController.text,
        name: nameController.text,
        image: imagePath ?? '',
      );
      BrandController.instance.uploadBrand(brand, image);
      clearFields();
      final snackBar = SnackBar(
        content: Center(
            child: Text(
          'Saved',
          style: tStyle.apply(color: TColors.white),
        )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: TColors.success,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Center(
            child: Text(
          'Some important fields were not filled out',
          style: tStyle.apply(color: TColors.white),
        )),
        behavior: SnackBarBehavior.floating,
        backgroundColor: TColors.warning,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
