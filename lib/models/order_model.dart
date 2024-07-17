import 'dart:math';

import 'package:apos/lib_exp.dart';

class Order {
  String id;
  String customerId;
  String customerName;
  List<Item> items;
  double totalAmount;
  int statusId;
  DateTime orderDate;

  OrderStatus status;

  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.orderDate,
    required this.totalAmount,
    required this.statusId,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      items: List.from(json["items"].map((x) => Item.fromJson(x))),
      orderDate: DateTime.parse(json['order_date']),
      totalAmount: json['total_amount'],
      statusId: json['status_id'],
      status: parseToOrderStatus(json["status_id"]),
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

Order tempOrder(int index) {
  final statusId = Random().nextInt(4);
  return Order(
    id: "$index",
    customerId: "$index$index",
    customerName: "Customer ${Consts.aToz[index]}",
    items: List.generate(
      Random().nextInt(2) + 3,
      (i) => tempItem(i),
    ),
    orderDate: DateTime.now(),
    totalAmount: Random().nextInt(1000) + 10000,
    statusId: statusId,
    status: parseToOrderStatus(statusId),
  );
}
