import 'package:apos/lib_exp.dart';

sealed class OrderState {}

class OrderStateInitial extends OrderState {
  OrderStateInitial();
}

class OrderStateLoading extends OrderState {}

class OrderStateFailed extends OrderState {
  final ErrorModel error;
  OrderStateFailed({required this.error});
}

class OrderStateSearched extends OrderState {
  final String query;
  OrderStateSearched(this.query);
}

class OrderStateStatusChangedUpdateProductModelSuccess extends OrderState {
  final OrderModel order;
  final int status;
  OrderStateStatusChangedUpdateProductModelSuccess({
    required this.order,
    required this.status,
  });
}

class OrderStateChangeSuccess extends OrderState {}
