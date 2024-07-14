import 'item_model.dart';

class Order {
  String id;
  String customerId;
  String customerName;
  List<Item> items;
  double totalAmount;
  int statusId;
  DateTime orderDate;

  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.orderDate,
    required this.totalAmount,
    required this.statusId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      items: List.from(json["items"].map((x) => Item.fromJson(x))),
      orderDate: DateTime.parse(json['order_date']),
      totalAmount: json['total_amount'],
      statusId: json['status_Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'customer_name': customerName,
      'items': List.from(items.map((x) => x)),
      'order_date': orderDate.toIso8601String(),
      'total_amount': totalAmount,
      'status_id': statusId,
    };
  }
}

Order tempOrder = Order(
  id: "12312",
  customerId: "1111",
  customerName: "Customer A",
  items: [],
  orderDate: DateTime.now(),
  totalAmount: 1000.00,
  statusId: 1,
);
