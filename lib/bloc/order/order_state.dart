import 'package:apos/lib_exp.dart';

sealed class OrderState {
  final List<OrderModel> orders;
  OrderState({required this.orders});
}

class OrderStateInitial extends OrderState {
  OrderStateInitial({required super.orders});
}

class OrderStateLoading extends OrderState {
  OrderStateLoading({required super.orders});
}

class OrderStateFail extends OrderState {
  final ErrorModel error;
  OrderStateFail({required this.error, required super.orders});
}

class OrderStateGetOrdersSuccess extends OrderState {
  OrderStateGetOrdersSuccess({required super.orders});
}

class OrderStateChangeSuccess extends OrderState {
  OrderStateChangeSuccess({required super.orders});
}
