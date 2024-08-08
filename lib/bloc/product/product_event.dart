import 'package:apos/lib_exp.dart';

sealed class ProductEvent {}

class ProductEventUploadImage extends ProductEvent {
  final AttachmentFile file;
  ProductEventUploadImage({required this.file});
}

class ProductEventCreateData extends ProductEvent {
  final ProductModel product;
  ProductEventCreateData({required this.product});
}

class ProductEventReadData extends ProductEvent {}

class ProductEventUpdateData extends ProductEvent {
  final ProductModel product;
  final bool checkTakenName;
  ProductEventUpdateData({
    required this.product,
    required this.checkTakenName,
  });
}

class ProductEventDeleteData extends ProductEvent {
  final String productId;
  ProductEventDeleteData({required this.productId});
}

class ProductEventSearch extends ProductEvent {
  final String query;
  ProductEventSearch({required this.query});
}
