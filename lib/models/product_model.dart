class Product {
  String? id;
  final String readableId;
  final String name;
  final List<String> base64Images;
  final String? description;
  final double price;
  final int stockQuantity;
  final String? categoryId;
  final String? categoryName;

  Product({
    this.id,
    required this.readableId,
    required this.name,
    required this.base64Images,
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
      base64Images: List.from(json["images"].map((x) => x)),
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
      'images': List.from(base64Images.map((x) => x)),
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
