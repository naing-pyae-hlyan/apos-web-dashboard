import 'package:apos/lib_exp.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateInitial(orders: [])) {
    on<OrderEventGetOrders>(_onGetOrders);
    on<OrderEventStatusChange>(_onOrderStatusChange);
  }

  Future<void> _onGetOrders(
    OrderEventGetOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderStateLoading(orders: state.orders));

    List<OrderModel> orders = List.generate(26, (index) => tempOrder(index));

    //
    CacheManager.orders = orders;

    emit(OrderStateGetOrdersSuccess(orders: orders));
  }

  Future<void> _onOrderStatusChange(
    OrderEventStatusChange event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderStateLoading(orders: state.orders));

    emit(OrderStateChangeSuccess(orders: state.orders));
  }
}
