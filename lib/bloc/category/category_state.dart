import 'package:apos/lib_exp.dart';

sealed class CategoryState {
  final List<Category> categories;
  CategoryState({required this.categories});
}

class CategoryStateInitial extends CategoryState {
  CategoryStateInitial({required super.categories});
}

class CategoryStateLoading extends CategoryState {
  CategoryStateLoading({required super.categories});
}

class CategoryStateFail extends CategoryState {
  final String error;
  CategoryStateFail({required this.error, required super.categories});
}

// Create
class CategoryStateCreateDataSuccess extends CategoryState {
  CategoryStateCreateDataSuccess({required super.categories});
}

// Read
class CategoryStateReadDataSuccess extends CategoryState {
  CategoryStateReadDataSuccess({required super.categories});
}

// Update
class CategoryStateUpdateDataSuccess extends CategoryState {
  CategoryStateUpdateDataSuccess({required super.categories});
}

// Delete
class CategoryStateDeleteDataSuccess extends CategoryState {
  CategoryStateDeleteDataSuccess({required super.categories});
}
