import 'package:apos/lib_exp.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateInitial()) {
    on<OrderEventStatusChangedUpdateProductModel>(
      _onStatusChangedUpdateProdcutModel,
    );
    on<OrderEventStatusChange>(_onOrderStatusChange);
    on<OrderEventSearch>(_onSearch);
  }

  Future<void> _onStatusChangedUpdateProdcutModel(
    OrderEventStatusChangedUpdateProductModel event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderStateLoading());
    if (event.status == OrderStatus.delivered.code) {
      final productRef = FFirestoreUtils.productCollection;
      for (ItemModel item in event.order.items) {
        final doc = await productRef.doc(item.id).get();
        final salesCount = doc.data()?.topSalesCount ?? 0;
        await productRef.doc(item.id).update({
          "top_sales_count": salesCount + item.qty,
        });
      }
      emit(OrderStateStatusChangedUpdateProductModelSuccess(
        order: event.order,
        status: event.status,
      ));
    } else {
      emit(OrderStateStatusChangedUpdateProductModelSuccess(
        order: event.order,
        status: event.status,
      ));
    }
  }

  Future<void> _onOrderStatusChange(
    OrderEventStatusChange event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderStateLoading());
    await FFirestoreUtils.orderCollection
        .doc(event.order.id)
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
