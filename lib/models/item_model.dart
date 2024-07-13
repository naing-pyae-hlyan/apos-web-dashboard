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

Item tempItem = Item(
  id: "123",
  name: "Item A",
  amount: 100.0,
  discount: 0.0,
  quantity: 2,
);
