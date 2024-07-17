import 'dart:math';

import 'package:apos/lib_exp.dart';

class Item {
  final String id;
  final String name;
  final double amount;
  final double discount;
  final int quantity;

  Item({
    required this.id,
    required this.name,
    required this.amount,
    required this.discount,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        discount: json["discount"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "discount": discount,
        "quantity": quantity,
      };
}

Item tempItem(int index) => Item(
      id: "#$index",
      name: "Item ${Consts.aToz[index]}",
      amount: Random().nextInt(1000) + 10000,
      discount: 0.0,
      quantity: Random().nextInt(1000),
    );
