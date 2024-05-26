import 'package:acquirer/common/widgets/images/rounded_image.dart';
import 'package:acquirer/features/shop/controllers/brand_controller.dart';
import 'package:acquirer/features/shop/controllers/category_controller.dart';
import 'package:acquirer/features/shop/controllers/product/product_controller.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/utils/constants/colors.dart';
import 'package:acquirer/utils/constants/sizes.dart';
import 'package:acquirer/utils/helpers/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final tStyle = const TextStyle().copyWith(fontSize: 15, fontWeight: FontWeight.w500, color: TColors.backgroundDark);
  final brandsId = BrandController.instance.allBrands.map<String>((brand) => brand.id).toList();
  final brandsName = BrandController.instance.allBrands.map<String>((brand) => brand.name).toList();
  final categoriesId = CategoryController.instance.allCategories.map<String>((category) => category.id).toList();
  final categoriesName = CategoryController.instance.allCategories.map<String>((category) => category.name).toList();
  final productsId = ProductController.instance.allProducts.map<String>((product) => product.id).toList();
  final productsTitle = ProductController.instance.allProducts.map<String>((product) => product.title).toList();

  String selectedBrand = BrandController.instance.allBrands.first.id;
  String selectedCategory = CategoryController.instance.allCategories.first.id;

  final idController = TextEditingController();
  final titleController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();
  final skuController = TextEditingController();
  final descriptionController = TextEditingController();

  String? imagePath;
  Uint8List? image;
  String? imageName;

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
            'Products',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.sm),
          TextField(
            controller: idController,
            maxLines: 1,
            style: tStyle,
            decoration: InputDecoration(
              hintText: '00001...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'Id*',
              labelStyle: tStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            ),
            onChanged: (value) {
              setState(() {
                if (idController.text != '' && productsId.contains(idController.text)) {
                  final product = ProductController.instance.allProducts.firstWhere((product) => product.id == idController.text);
                  titleController.text = product.title;
                  stockController.text = product.stock.toString();
                  priceController.text = product.price.toString();

                  imagePath = product.thumbnail;
                  image = null;
                  imageName = null;

                  selectedBrand = product.brandId!;
                  selectedCategory = product.categoryId!;
                  skuController.text = product.sku ?? '';
                  descriptionController.text = product.description ?? '';
                }
              });
            },
          ),
          const SizedBox(height: TSizes.sm),
          TextField(
            controller: titleController,
            maxLines: 1,
            style: tStyle,
            decoration: InputDecoration(
              hintText: 'White T-Shirt...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'Title*',
              labelStyle: tStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            ),
          ),
          const SizedBox(height: TSizes.sm),
          TextField(
            controller: stockController,
            maxLines: 1,
            style: tStyle,
            decoration: InputDecoration(
              hintText: '32...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'Stock (amount)*',
              labelStyle: tStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            ),
          ),
          const SizedBox(height: TSizes.sm),
          TextField(
            controller: priceController,
            maxLines: 1,
            style: tStyle,
            decoration: InputDecoration(
              hintText: '49.99...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'Price (\$)*',
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
                    imageName = result.$2;
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
          const SizedBox(height: TSizes.xxs),
          Row(
            children: [
              Text('Brand:', style: tStyle),
              const SizedBox(width: TSizes.md),
              DropdownButton<String>(
                value: selectedBrand,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBrand = newValue!;
                  });
                },
                items: brandsId.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(brandsName[brandsId.indexOf(value)], style: tStyle),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            children: [
              Text('Category:', style: tStyle),
              const SizedBox(width: TSizes.md),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: categoriesId.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(categoriesName[categoriesId.indexOf(value)], style: tStyle),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: TSizes.xxs),
          TextField(
            controller: skuController,
            maxLines: 1,
            style: tStyle,
            decoration: InputDecoration(
              hintText: 'ABR4568...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'SKU',
              labelStyle: tStyle,
              contentPadding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            ),
          ),
          const SizedBox(height: TSizes.sm),
          TextField(
            controller: descriptionController,
            maxLines: null,
            style: tStyle,
            decoration: InputDecoration(
              hintText: 'Any information about this product...',
              hintStyle: tStyle.copyWith(color: TColors.darkGrey),
              labelText: 'Description',
              labelStyle: tStyle,
              contentPadding: const EdgeInsets.all(TSizes.sm),
            ),
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
      selectedBrand = BrandController.instance.allBrands.first.id;
      selectedCategory = CategoryController.instance.allCategories.first.id;
      imagePath = null;
      imageName = null;
      image = null;
      titleController.text = '';
      stockController.text = '';
      priceController.text = '';
      skuController.text = '';
      descriptionController.text = '';
    });
  }

  void saveProduct() {
    if (idController.text != '' &&
        titleController.text != '' &&
        stockController.text != '' &&
        priceController.text != '' &&
        (image != null || imagePath != null)) {
      ProductModel product = ProductModel(
        id: idController.text,
        title: titleController.text,
        stock: int.parse(stockController.text),
        price: double.parse(priceController.text),
        thumbnail: imagePath ?? '',
        images: [imagePath ?? ''],
        brandId: selectedBrand,
        categoryId: selectedCategory,
        sku: skuController.text,
        description: descriptionController.text,
        rating: productsId.contains(idController.text)
            ? ProductController.instance.allProducts.firstWhere((element) => element.id == idController.text).rating
            : 0,
        reviews: productsId.contains(idController.text)
            ? ProductController.instance.allProducts.firstWhere((element) => element.id == idController.text).reviews
            : 0,
      );
      ProductController.instance.uploadProduct(product, image, imageName);
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
