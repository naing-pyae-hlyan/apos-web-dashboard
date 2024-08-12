import 'package:apos/lib_exp.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerStateInitial()) {
    on<CustomerEventSearch>(_onSearch);
    on<CustomerEventUpdateStatus>(_onStatusChange);
  }

  Future<void> _onStatusChange(
    CustomerEventUpdateStatus event,
    Emitter<CustomerState> emit,
  ) async {
    emit(CustomerStateLoading());
    await FFirestoreUtils.customerCollection
        .doc(event.customerId)
        .update({"status": event.status})
        .then((_) => emit(CustomerStateUpdateStatusSuccess()))
        .catchError(
          (error) => emit(_stateFail(message: error.toString())),
        );
  }

  Future<void> _onSearch(
    CustomerEventSearch event,
    Emitter<CustomerState> emit,
  ) async {
    emit(CustomerStateSearch(event.query));
  }

  CustomerStateFailed _stateFail({required String message, int code = 1}) =>
      CustomerStateFailed(error: ErrorModel(message: message, code: code));
}
