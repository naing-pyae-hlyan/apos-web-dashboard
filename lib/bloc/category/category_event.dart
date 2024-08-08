import 'package:apos/lib_exp.dart';

sealed class CategoryEvent {}

class CategoryEventCreateData extends CategoryEvent {
  final CategoryModel category;
  CategoryEventCreateData({required this.category});
}

class CategoryEventReadData extends CategoryEvent {
  final Function()? readSuccess;
  CategoryEventReadData({this.readSuccess});
}

class CategoryEventUpdateData extends CategoryEvent {
  final CategoryModel category;
  final String currentCategoryName;
  CategoryEventUpdateData({
    required this.currentCategoryName,
    required this.category,
  });
}

class CategoryEventDeleteData extends CategoryEvent {
  final String categoryId;
  CategoryEventDeleteData({required this.categoryId});
}

class CategoryEventSearch extends CategoryEvent {
  final String query;
  CategoryEventSearch({required this.query});
}
