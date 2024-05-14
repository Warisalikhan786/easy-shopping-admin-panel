// ignore_for_file: file_names

class CategoriesModel {
  final String categoryId;
  final String categoryName;
  final String categoryImg;
  final dynamic createdAt;
  final dynamic updatedAt;

  CategoriesModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImg,
    required this.createdAt,
    required this.updatedAt,
  });

  // Serialize the CategoriesModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImg': categoryImg,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a CategoriesModel instance from a JSON map
  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryImg: json['categoryImg'],
      createdAt: json['createdAt'].toString(),
      updatedAt: json['updatedAt'].toString(),
    );
  }
}
