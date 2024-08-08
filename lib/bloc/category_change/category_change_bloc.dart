import 'package:apos/lib_exp.dart';

class CategoryChangeBloc
    extends Bloc<CategoryChangeEvent, CategoryChangeState> {
  CategoryChangeBloc() : super(CategoryChangeStateInitial()) {
    on<CategoryChangeEventInit>(_onInit);
    on<CategoryChangeEventSelectCategory>(_onSelectCategory);
    on<CategoryChangeEventAddSizes>(_onAddSizes);
    on<CategoryChangeEventAddColors>(_onAddColors);
  }

  final List<ProductSizeModel> _productSizes = [];
  final List<ProductColorModel> _productColors = [];
  CategoryModel? _selectedCategory;
  CategoryModel? get selectedCategory => _selectedCategory;

  List<String> get categorySizes {
    List<String> result = _selectedCategory?.sizes ?? [];
    result.removeWhere(
        (String size) => size == "-" || size == " " || size.isEmpty);
    return result;
  }

  List<int> get categoryHexColors {
    return _selectedCategory?.colorHexs ?? [];
  }

  // List<ProductSize> get productSizes => _productSizes;
  List<String> get productSizesAsStrings {
    List<String> result =
        ProductSizeModel.parseProductSizesToName(_productSizes);
    result.removeWhere(
      (String size) => size == "-" || size.isEmpty || size == " ",
    );
    return result;
  }

  // List<ProductColor> get productColors => _productColors;
  List<int> get productColorsAsHexs {
    return ProductColorModel.parseProductColorsToHexs(_productColors);
  }

  void _onInit(
    CategoryChangeEventInit event,
    Emitter<CategoryChangeState> emit,
  ) {
    _productSizes.clear();
    _productColors.clear();
    _selectedCategory = null;
  }

  void _onSelectCategory(
    CategoryChangeEventSelectCategory event,
    Emitter<CategoryChangeState> emit,
  ) {
    _selectedCategory = event.category;
    _selectedCategory?.sizes.removeWhere(
      (size) => size == "-" || size == " " || size.isEmpty,
    );
    _productSizes.clear();
    _productColors.clear();
    emit(CategoryChangeStateSelectedCategory());
  }

  void _onAddSizes(
      CategoryChangeEventAddSizes event, Emitter<CategoryChangeState> emit) {
    _productSizes.clear();
    _productSizes.addAll(event.sizes);
    emit(CategoryChangeStateHasSizes());
  }

  void _onAddColors(
      CategoryChangeEventAddColors event, Emitter<CategoryChangeState> emit) {
    _productColors.clear();
    _productColors.addAll(event.colors);
    emit(CategoryChangeStateHasColors());
  }
}
