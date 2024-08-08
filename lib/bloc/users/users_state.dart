import 'package:apos/lib_exp.dart';

sealed class UsersState {}

class UsersStateInitial extends UsersState {}

class UsersStateLoading extends UsersState {}

class UsersStateFail extends UsersState {
  final ErrorModel error;
  UsersStateFail({required this.error});
}

// Create
class UsersStateCreateSuccess extends UsersState {}

class UsersStateUpdateSuccess extends UsersState {}

class UsersStateDeleteSuccess extends UsersState {}

class UsersStateSearch extends UsersState {
  final String query;
  UsersStateSearch({required this.query});
}
