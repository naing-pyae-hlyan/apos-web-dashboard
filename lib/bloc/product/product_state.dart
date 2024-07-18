import 'package:apos/lib_exp.dart';

sealed class ProductState {
  final List<Product> products;
  ProductState({required this.products});
}

class ProductStateInitial extends ProductState {
  ProductStateInitial({required super.products});
}

class ProductStateLoading extends ProductState {
  ProductStateLoading({required super.products});
}

class ProductStateFail extends ProductState {
  final ErrorModel error;
  ProductStateFail({required this.error, required super.products});
}

// Create
class ProductStateCreateDataSuccess extends ProductState {
  ProductStateCreateDataSuccess({required super.products});
}

// Read
class ProductStateReadDataSuccess extends ProductState {
  ProductStateReadDataSuccess({required super.products});
}

// Update
class ProductStateUpdateDataSuccess extends ProductState {
  ProductStateUpdateDataSuccess({required super.products});
}

// Delete
class ProductStateDeleteDataSuccess extends ProductState {
  ProductStateDeleteDataSuccess({required super.products});
}
