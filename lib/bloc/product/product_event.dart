import 'package:apos/lib_exp.dart';

sealed class ProductEvent {}

class ProductEventCreateData extends ProductEvent {
  final Product product;
  ProductEventCreateData({required this.product});
}

class ProductEventReadData extends ProductEvent {}

class ProductEventUpdateData extends ProductEvent {
  final Product product;
  ProductEventUpdateData({required this.product});
}

class ProductEventDeleteData extends ProductEvent {
  final String productId;
  ProductEventDeleteData({required this.productId});
}

class ProductEventSearch extends ProductEvent {
  final String query;
  ProductEventSearch({required this.query});
}

class ProductEventPickProductImage extends ProductEvent {}

class ProductEventRemoveProductImage extends ProductEvent {}
