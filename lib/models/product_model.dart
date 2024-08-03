class ProductModel {
  final String categoryId;
  final String categoryName;
  final String deliveryTime;
  final String fullPrice;
  final String productDescription;
  final String productId;
  final List productImages;
  final String productName;
  final String salePrice;
  final dynamic updatedAt;
  final dynamic createdAt;
  final bool isSale;

  ProductModel(
      {required this.categoryId,
      required this.categoryName,
      required this.deliveryTime,
      required this.fullPrice,
      required this.productDescription,
      required this.productId,
      required this.productImages,
      required this.productName,
      required this.salePrice,
      required this.updatedAt,
      required this.createdAt,
      required this.isSale});

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'deliveryTime': deliveryTime,
      'fullPrice': fullPrice,
      'productDescription': productDescription,
      'productId': productId,
      'productImages': productImages,
      'productName': productName,
      'salePrice': salePrice,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'isSale': isSale
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
        categoryId: json['categoryId'],
        categoryName: json['categoryName'],
        deliveryTime: json['deliveryTime'],
        fullPrice: json['fullPrice'],
        productDescription: json['productDescription'],
        productId: json['productId'],
        productImages: json['productImages'],
        productName: json['productName'],
        salePrice: json['salePrice'],
        updatedAt: json['updatedAt'],
        createdAt: json['createdAt'],
        isSale: json['isSale']);
  }
}
