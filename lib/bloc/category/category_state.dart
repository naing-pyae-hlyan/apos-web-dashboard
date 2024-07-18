import 'package:apos/lib_exp.dart';

sealed class CategoryState  {}

class CategoryStateInitial extends CategoryState {}

class CategoryStateLoading extends CategoryState {}

class CategoryDialogStateLoading extends CategoryState {}

class CategoryStateFail extends CategoryState {
  final ErrorModel error;
  CategoryStateFail({required this.error});
}

class CategoryDialogStateFail extends CategoryState {
  final ErrorModel error;
  CategoryDialogStateFail({required this.error});
}

// Create
class CategoryStateCreateDataSuccess extends CategoryState {}

// Update
class CategoryStateUpdateDataSuccess extends CategoryState {}

// Delete
class CategoryStateDeleteDataSuccess extends CategoryState {}
