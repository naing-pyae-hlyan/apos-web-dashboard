import 'package:apos/lib_exp.dart';

sealed class CategoryEvent {}

class CategoryEventCreateData extends CategoryEvent {
  final Category category;
  CategoryEventCreateData({required this.category});
}

class CategoryEventReadData extends CategoryEvent {}

class CategoryEventUpdateData extends CategoryEvent {
  final Category category;
  CategoryEventUpdateData({required this.category});
}

class CategoryEventDeleteData extends CategoryEvent {
  final String categoryId;
  CategoryEventDeleteData({required this.categoryId});
}
