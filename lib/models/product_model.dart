class Product {
  String id;
  String name;
  String? image;
  String? description;
  double price;
  int stockQuantity;
  String categoryId;
  String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.categoryId,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
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
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'category_Id': categoryId,
      'category_Name': categoryName,
    };
  }
}

Product tempProduct = Product(
  id: "",
  name: "Product X",
  image: "",
  description: "",
  price: 123,
  stockQuantity: 1000,
  categoryId: "",
  categoryName: "",
);
