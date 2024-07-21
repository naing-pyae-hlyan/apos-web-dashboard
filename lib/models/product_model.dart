class Product {
  String? id;
  final String readableId;
  final String name;
  final String? image;
  final String? description;
  final double price;
  final int stockQuantity;
  final String? categoryId;
  final String? categoryName;

  Product({
    this.id,
    required this.readableId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.categoryId,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json, String docId) {
    return Product(
      id: docId,
      readableId: json["id"],
      name: json['name'],
      image: json["image"],
      description: json['description'],
      price: json['price'],
      stockQuantity: json['stock_quantity'],
      categoryId: json['category_id'],
      categoryName: json["category_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': readableId,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Product && id == other.id;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
