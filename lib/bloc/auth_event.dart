sealed class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  String username;
  String password;
  AuthEventLogin({required this.username, required this.password});
}
