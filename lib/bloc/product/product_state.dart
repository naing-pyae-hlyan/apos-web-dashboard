import 'package:apos/lib_exp.dart';

sealed class ProductState {
  ProductState();
}

class ProductStateInitial extends ProductState {
  ProductStateInitial();
}

class ProductStateLoading extends ProductState {
  ProductStateLoading();
}

class ProductDialogStateLoading extends ProductState {
  ProductDialogStateLoading();
}

class ProductStateFail extends ProductState {
  final ErrorModel error;
  ProductStateFail({required this.error});
}

class ProductDialogStateFail extends ProductState {
  final ErrorModel error;
  ProductDialogStateFail({required this.error});
}

// Create
class ProductStateCreateDataSuccess extends ProductState {}

// Update
class ProductStateUpdateDataSuccess extends ProductState {}

// Delete
class ProductStateDeleteDataSuccess extends ProductState {}

// Search
class ProductStateSearch extends ProductState {
  final String query;
  ProductStateSearch({required this.query});
}
