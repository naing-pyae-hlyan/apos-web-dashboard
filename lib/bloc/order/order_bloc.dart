import 'package:apos/lib_exp.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateInitial()) {
    on<OrderEventStatusChange>(_onOrderStatusChange);
    on<OrderEventSearch>(_onSearch);
  }

  Future<void> _onOrderStatusChange(
    OrderEventStatusChange event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderStateLoading());
    await FFirestoreUtils.orderCollection
        .doc(event.orderId)
        .update({"status_id": event.status})
        .then((_) => emit(OrderStateChangeSuccess()))
        .catchError((error) => emit(_stateFail(message: error.toString())));
  }

  Future<void> _onSearch(
    OrderEventSearch event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderStateSearched(event.query));
  }

  OrderStateFailed _stateFail({required String message, int code = 1}) =>
      OrderStateFailed(error: ErrorModel(message: message, code: code));
}
