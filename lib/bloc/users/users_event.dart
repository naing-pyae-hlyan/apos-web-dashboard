import 'package:apos/lib_exp.dart';

sealed class UsersEvent {}

class UsersEventRead extends UsersEvent {
  final Function()? readSuccess;
  UsersEventRead({this.readSuccess});
}

class UsersEventCreate extends UsersEvent {
  final UserModel user;
  UsersEventCreate({required this.user});
}

class UsersEventUpdate extends UsersEvent {
  final UserModel user;
  UsersEventUpdate({required this.user});
}

class UsersEventDelete extends UsersEvent {
  final String userId;
  UsersEventDelete({required this.userId});
}

class UsersEventSearch extends UsersEvent {
  final String query;
  UsersEventSearch({required this.query});
}
