import 'package:acquirer/features/shop/models/product_attribute_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Class with Model of Product
class ProductModel {
  String id;
  String title;
  int stock;
  double price;
  String thumbnail;
  List<String>? images;
  String? brandId;
  String? categoryId;
  String? sku;
  String? description;
  ProductAttributeModel? productAttributes;
  int? reviews;
  double? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    this.images,
    this.brandId,
    this.categoryId,
    this.sku,
    this.description,
    this.productAttributes,
    this.rating,
    this.reviews,
  });

  /// Empty helper function
  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '');

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Thumbnail': thumbnail,
      'Images': images ?? [],
      'BrandId': brandId,
      'CategoryId': categoryId,
      'SKU': sku,
      'Description': description,
      // ignore: prefer_null_aware_operators
      'ProductAttributes': productAttributes != null ? productAttributes!.toJson() : null,
      'Rating': rating,
      'Reviews': reviews,
    };
  }

  /// Map Json oriented query document snapshot from Firebase to Model
  factory ProductModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;

    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      brandId: data['BrandId'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      sku: data['SKU'] ?? '',
      description: data['Description'] ?? '',
      productAttributes: data['ProductAttributes'] == null ? null : ProductAttributeModel.fromJson(data['ProductAttributes']),
      rating: double.parse((data['Rating'] ?? 0).toString()),
      reviews: data['Reviews'] ?? 0,
    );
  }

  /// Map Json oriented query document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapShot(QueryDocumentSnapshot<Map<String, dynamic>> document) {
    // ignore: unnecessary_cast
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      brandId: data['BrandId'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      sku: data['SKU'] ?? '',
      description: data['Description'] ?? '',
      productAttributes: data['ProductAttributes'] == null ? null : ProductAttributeModel.fromJson(data['ProductAttributes']),
      rating: data['Rating'] ?? 0,
      reviews: data['Reviews'] ?? 0,
    );
  }
}
