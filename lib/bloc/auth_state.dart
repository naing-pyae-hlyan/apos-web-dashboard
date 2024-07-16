sealed class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateFail extends AuthState {
  final dynamic code;
  final String error;
  AuthStateFail({this.code, required this.error});
}

class AuthStateSuccess extends AuthState {}
