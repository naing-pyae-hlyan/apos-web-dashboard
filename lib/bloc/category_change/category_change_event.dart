import 'package:apos/lib_exp.dart';

sealed class CategoryChangeEvent {}

class CategoryChangeEventInit extends CategoryChangeEvent {}

class CategoryChangeEventSelectCategory extends CategoryChangeEvent {
  final Category? category;
  CategoryChangeEventSelectCategory(this.category);
}

class CategoryChangeEventAddSizes extends CategoryChangeEvent {
  final List<ProductSize> sizes;
  CategoryChangeEventAddSizes(this.sizes);
}

class CategoryChangeEventAddColors extends CategoryChangeEvent {
  final List<ProductColor> colors;
  CategoryChangeEventAddColors(this.colors);
}
