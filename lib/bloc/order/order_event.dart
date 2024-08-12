sealed class OrderEvent {}

class OrderEventStatusChange extends OrderEvent {
  final String orderId;
  final int status;
  OrderEventStatusChange({required this.orderId, required this.status});
}

class OrderEventSearch extends OrderEvent {
  final String query;
  OrderEventSearch(this.query);
}
