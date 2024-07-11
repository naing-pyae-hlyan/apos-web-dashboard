import 'package:apos/lib_exp.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryStateInitial(categories: [])) {
    on<CategoryEventCreateData>(_onCreate);
    on<CategoryEventReadData>(_onRead);
    on<CategoryEventUpdateData>(_onUpdate);
    on<CategoryEventDeleteData>(_onDelete);
  }

  Future<void> _onCreate(
    CategoryEventCreateData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryStateLoading(categories: state.categories));

    CacheManager.categories.add(event.category);
    emit(CategoryStateCreateDataSuccess(categories: CacheManager.categories));
  }

  Future<void> _onRead(
    CategoryEventReadData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryStateLoading(categories: state.categories));

    List<Category> categories = List.generate(
      20,
      (index) => Category(
          id: DateTime.now().toIso8601String(),
          name: "Name #$index",
          description: "Exercitation fugiat cillum occaecat laborum et."),
    );

    //
    CacheManager.categories = categories;

    emit(CategoryStateReadDataSuccess(categories: categories));
  }

  Future<void> _onUpdate(
    CategoryEventUpdateData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryStateLoading(categories: state.categories));

    for (Category category in CacheManager.categories) {
      if (category.id == event.category.id) {
        category = Category(
          id: event.category.id,
          name: event.category.name,
          description: event.category.description,
        );
      }
    }
    emit(CategoryStateUpdateDataSuccess(categories: CacheManager.categories));
  }

  Future<void> _onDelete(
    CategoryEventDeleteData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryStateLoading(categories: state.categories));

    List<Category> categories = CacheManager.categories;
    categories.removeWhere(
      (Category category) => event.categoryId == category.id,
    );
    CacheManager.categories = categories;

    emit(CategoryStateDeleteDataSuccess(categories: categories));
  }
}
