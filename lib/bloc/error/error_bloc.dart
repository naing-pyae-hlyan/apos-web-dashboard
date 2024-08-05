import 'package:apos/lib_exp.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(ErrorStateInitial()) {
    on<ErrorEventSetError>(_onErrorSet);
  }

  Future<void> _onErrorSet(
    ErrorEventSetError event,
    Emitter<ErrorState> emit,
  ) async {
    if (event.errorKey == null || event.error == null) {
      emit(ErrorStateNoError());
      return;
    }
    emit(ErrorStateHasError(
      errorKey: event.errorKey!,
      error: event.error!,
    ));
  }
}
