import 'package:apos/lib_exp.dart';

sealed class CategoryChangeEvent {}

class CategoryChangeEventInit extends CategoryChangeEvent {}

class CategoryChangeEventSelectCategory extends CategoryChangeEvent {
  final CategoryModel? category;
  CategoryChangeEventSelectCategory(this.category);
}

class CategoryChangeEventAddSizes extends CategoryChangeEvent {
  final List<ProductSizeModel> sizes;
  CategoryChangeEventAddSizes(this.sizes);
}

class CategoryChangeEventAddColors extends CategoryChangeEvent {
  final List<ProductColorModel> colors;
  CategoryChangeEventAddColors(this.colors);
}
