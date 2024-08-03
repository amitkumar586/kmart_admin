class CategoriesModel {
  final String categoryId;
  final List categoryImage;
  final String categoryName;
  final dynamic createdAt;
  final dynamic updatedAt;

  CategoriesModel({
    required this.categoryId,
    required this.categoryImage,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImage': categoryImage,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> json) {
    return CategoriesModel(
      categoryId: json['categoryId'],
      categoryImage: json['categoryImage'],
      categoryName: json['categoryName'],
      createdAt: json['createdAt'],
      updatedAt: json[' updatedAt'],
    );
  }
}
