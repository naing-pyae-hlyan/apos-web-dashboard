import 'package:apos/lib_exp.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    on<AuthEventLogin>(_onLogin);
  }

  Future<void> _onLogin(
    AuthEventLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    if (event.username.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        AuthStateFail(error: ErrorModel(message: "Enter username", code: 1)),
      );
      return;
    }
    if (event.password != "welcome") {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        AuthStateFail(error: ErrorModel(message: "Invalid password", code: 2)),
      );
      return;
    }
    if (event.username != "admin") {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        AuthStateFail(error: ErrorModel(message: "User not found", code: 1)),
      );
      return;
    }
    await Future.delayed(const Duration(seconds: 3));

    emit(AuthStateSuccess());
  }
}
