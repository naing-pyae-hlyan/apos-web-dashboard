import 'package:apos/lib_exp.dart';

sealed class OrderEvent {}

class OrderEventStatusChangedUpdateProductModel extends OrderEvent {
  final OrderModel order;
  final int status;
  OrderEventStatusChangedUpdateProductModel({
    required this.order,
    required this.status,
  });
}

class OrderEventStatusChange extends OrderEvent {
  final OrderModel order;
  final int status;
  OrderEventStatusChange({required this.order, required this.status});
}

class OrderEventSearch extends OrderEvent {
  final String query;
  OrderEventSearch(this.query);
}
