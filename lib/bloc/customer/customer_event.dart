sealed class CustomerEvent {}

class CustomerEventUpdateStatus extends CustomerEvent {
  final String customerId;
  final int status;
  CustomerEventUpdateStatus({required this.customerId, required this.status});
}

class CustomerEventSearch extends CustomerEvent {
  final String query;
  CustomerEventSearch(this.query);
}
