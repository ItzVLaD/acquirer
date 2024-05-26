import 'package:acquirer/features/shop/models/brand_model.dart';
import 'package:acquirer/features/shop/models/category_model.dart';
import 'package:acquirer/features/shop/models/product_attribute_model.dart';
import 'package:acquirer/features/shop/models/product_model.dart';
import 'package:acquirer/utils/constants/image_strings.dart';

/// Custom class to load DummyData from assets to Firebase
class DummyData {
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Animals', image: TImages.animalIcon, isFeatured: true),
    CategoryModel(id: '2', name: 'Clothes', image: TImages.clothIcon, isFeatured: true),
    CategoryModel(id: '3', name: 'Sports', image: TImages.sportIcon, isFeatured: true),
    CategoryModel(id: '4', name: 'Furniture', image: TImages.furnitureIcon, isFeatured: true),
    CategoryModel(id: '5', name: 'Jewelery', image: TImages.jeweleryIcon, isFeatured: true),
  ];

  static final List<BrandModel> brands = [
    BrandModel(id: '1', name: 'Nike', image: TImages.nikeLogo),
    BrandModel(id: '2', name: 'Zara', image: TImages.zaraLogo),
    BrandModel(id: '3', name: 'Ikea', image: TImages.ikeaLogo),
  ];

  static final List<ProductModel> products = [
    ProductModel(
      id: '00001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 49.99,
      thumbnail: TImages.productImage1,
      description: 'Green Nike sports shoe',
      brandId: '1',
      categoryId: '3',
      images: [TImages.productImage1],
      sku: 'ABR4568',
      productAttributes: ProductAttributeModel(
        name: 'Size',
        attributes: {
          '38': {
            'Price': 45.99,
            'Stock': 9,
          },
          '40': {
            'Price': 47.99,
            'Stock': 3,
          },
          '42': {
            'Price': 49.99,
            'Stock': 0,
          },
        },
      ),
    ),
    ProductModel(
      id: '00002',
      title: 'Blue T-shirt',
      stock: 10,
      price: 10.00,
      thumbnail: TImages.productImage69,
      description: 'This is a product description for blue T-shirt brand Zara',
      brandId: '1',
      categoryId: '2',
      images: [TImages.productImage69, TImages.productImage68],
      sku: 'ABR4568',
      productAttributes: null,
    ),
    ProductModel(
      id: '00003',
      title: 'Leather brown Jacket',
      stock: 10,
      price: 99.99,
      thumbnail: TImages.productImage64,
      description: 'This is a product description for Leather brown Jacket brand Zara',
      brandId: '1',
      categoryId: '2',
      images: [TImages.productImage64],
      sku: 'ABR4568',
      productAttributes: null,
    ),
    ProductModel(
      id: '00004',
      title: 'TOMI Dog food',
      stock: 9,
      price: 20.00,
      thumbnail: TImages.productImage18,
      description: 'This is a product description for TOMI Dog food brand ANY',
      brandId: '1',
      categoryId: '1',
      images: [TImages.productImage18],
      sku: 'ABR4568',
      productAttributes: null,
    ),
    ProductModel(
      id: '00005',
      title: 'Kitchen dining table',
      stock: 9,
      price: 119.49,
      thumbnail: TImages.productImage37,
      description: 'This is a product description for Kitchen dining table brand ANY',
      brandId: '1',
      categoryId: '4',
      images: [TImages.productImage37],
      sku: 'ABR4568',
      productAttributes: null,
    ),
    ProductModel(
      id: '00006',
      title: 'Office chair',
      stock: 9,
      price: 44.99,
      thumbnail: TImages.productImage39,
      description: 'This is a product description for Office chair brand ANY',
      brandId: '1',
      categoryId: '1',
      images: [TImages.productImage39],
      sku: 'ABR4568',
      productAttributes: null,
    ),
  ];
}
