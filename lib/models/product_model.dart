import 'dart:math';

import 'package:apos/lib_exp.dart';

class Product {
  String? id;
  String name;
  String? image;
  String? description;
  double price;
  int stockQuantity;
  String categoryId;
  String categoryName;

  Product({
    this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.categoryId,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id,
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
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }
}

Product tempProduct(int index) => Product(
      id: "#$index",
      name: "Product ${Consts.aToz[index]}",
      image: "",
      description: "Lorem Ipsum",
      price: Random().nextInt(1000) + 10000,
      stockQuantity: Random().nextInt(1000),
      categoryId: "",
      categoryName: "",
    );
