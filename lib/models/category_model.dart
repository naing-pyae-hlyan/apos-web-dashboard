import 'package:apos/lib_exp.dart';

class Category {
  String id;
  String name;
  String description;

  Category({required this.id, required this.name, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

Category tempCategory(int index) => Category(
      id: "$index",
      name: "Category ${Consts.aToz[index]}",
      description: "Lorem Ipsm",
    );
