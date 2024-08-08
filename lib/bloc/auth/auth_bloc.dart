import 'package:apos/lib_exp.dart';
import 'package:apos/main.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
  }

  Future<void> _onLogout(
    AuthEventLogout event,
    Emitter<AuthState> emit,
  ) async {
    CacheManager.clear();
    await SpHelper.clear();

    if (navigatorKey.currentContext != null) {
      navigatorKey.currentContext!.pushAndRemoveUntil(
        SplashPage(key: UniqueKey()),
      );
    }
  }

  Future<void> _onLogin(
    AuthEventLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    if (event.email.isEmpty) {
      emit(
        AuthStateFail(error: ErrorModel(message: "Enter Email", code: 1)),
      );
      return;
    }
    if (event.password.isEmpty) {
      emit(
        AuthStateFail(error: ErrorModel(message: "Invalid Password", code: 2)),
      );
      return;
    }

    final hashPassword = HashUtils.hashPassword(event.password);

    await FFirestoreUtils.userCollection.get().then(
      (QuerySnapshot<UserModel> snapshot) async {
        bool authorize = false;
        for (var doc in snapshot.docs) {
          if (event.email == doc.data().email &&
              hashPassword == doc.data().password) {
            authorize = true;
            CacheManager.currentUser = doc.data();
            break;
          }
        }

        if (authorize) {
          if (event.rememberMe) {
            await SpHelper.rememberMe(
              email: event.email,
              password: event.password,
            );
          }
          emit(AuthStateLoginSuccess());
        } else {
          emit(
            AuthStateFail(
              error: ErrorModel(message: "Invalid Email or Password", code: 2),
            ),
          );
        }
      },
    ).catchError((error) {
      emit(AuthStateFail(
        error: ErrorModel(message: error.toString(), code: 2),
      ));
    });
  }
}
