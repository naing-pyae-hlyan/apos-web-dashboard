import 'package:apos/lib_exp.dart';

sealed class OrderEvent {}

class OrderEventGetOrders extends OrderEvent {}

class OrderEventStatusChange extends OrderEvent {
  final OrderStatus static;
  OrderEventStatusChange({required this.static});
}
