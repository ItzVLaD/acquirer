import 'package:cloud_firestore/cloud_firestore.dart';

/// Class with Model of Brand
class BrandModel {
  String id;
  String name;
  String image;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
  });

  /// Empty helper function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
    };
  }

  /// Map Json ariented document snapshot from Firebase to Model
  factory BrandModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
      );
    } else {
      return BrandModel.empty();
    }
  }
}
