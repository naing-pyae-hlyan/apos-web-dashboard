import 'package:apos/lib_exp.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  // final FirebaseFirestore _database;
  final CollectionReference _categoryRef;
  CategoryBloc({required FirebaseFirestore database})
      // : _database = database,
      : _categoryRef = database.collection("category").withConverter<Category>(
              fromFirestore: (snapshot, _) => Category.fromJson(
                snapshot.data()!,
                snapshot.id,
              ),
              toFirestore: (category, _) => category.toJson(),
            ),
        super(CategoryStateInitial()) {
    on<CategoryEventCreateData>(_onCreate);
    on<CategoryEventUpdateData>(_onUpdate);
    on<CategoryEventDeleteData>(_onDelete);
  }

  Future<void> _onCreate(
    CategoryEventCreateData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryDialogStateLoading());
    if (event.category.name.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter category name"));
      return;
    }

    var same = CacheManager.categories.where(
      (Category category) => category.name == event.category.name,
    );

    if (same.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Name is already taken"));
      return;
    }

    await _categoryRef.add(event.category).then(
      (_) {
        emit(CategoryStateCreateDataSuccess());
      },
    ).catchError(
      (error) {
        emit(
          CategoryDialogStateFail(
            error: ErrorModel(message: error.toString(), code: 1),
          ),
        );
      },
    );
  }

  Future<void> _onUpdate(
    CategoryEventUpdateData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryDialogStateLoading());
    if (event.category.name.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter category name"));
      return;
    }

    var same = CacheManager.categories.where(
      (Category category) => category.name == event.category.name,
    );

    if (same.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Name is already taken"));
      return;
    }

    await _categoryRef
        .doc(event.category.id)
        .update(event.category.toJson())
        .then(
      (_) {
        emit(CategoryStateUpdateDataSuccess());
      },
    ).catchError(
      (error) {
        emit(_dialogStateFail(message: error.toString()));
      },
    );
  }

  Future<void> _onDelete(
    CategoryEventDeleteData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryStateLoading());

    _categoryRef.doc(event.categoryId).delete().then(
      (_) {
        emit(CategoryStateDeleteDataSuccess());
      },
    ).catchError(
      (error) {
        emit(_dialogStateFail(message: error.toString()));
      },
    );

    emit(CategoryStateDeleteDataSuccess());
  }

  CategoryDialogStateFail _dialogStateFail({
    required String message,
    int code = 1,
  }) =>
      CategoryDialogStateFail(
        error: ErrorModel(message: message, code: code),
      );
}
