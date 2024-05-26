/// Class with Model of ProductAttribute
class ProductAttributeModel {
  String name;
  Map<String, Map<String, dynamic>> attributes;

  ProductAttributeModel({
    required this.name,
    required this.attributes,
  });

  /// Empty helper function
  static ProductAttributeModel empty() => ProductAttributeModel(name: '', attributes: {});

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Attributes': attributes,
    };
  }

  /// Map Json ariented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      Map<String, Map<String, dynamic>> attributesMap = {};
      data['Attributes'].forEach((key, value) {
        attributesMap[key] = Map<String, dynamic>.from(value);
      });
      return ProductAttributeModel(
        name: data.containsKey('Name') ? data['Name'] : '',
        attributes: attributesMap,
      );
    } else {
      return ProductAttributeModel.empty();
    }
  }
}
