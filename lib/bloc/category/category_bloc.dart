import 'dart:async';
import 'package:apos/lib_exp.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryStateInitial()) {
    on<CategoryEventReadData>(_onRead);
    on<CategoryEventCreateData>(_onCreate);
    on<CategoryEventUpdateData>(_onUpdate);
    on<CategoryEventDeleteData>(_onDelete);
    on<CategoryEventSearch>(_onSearch);
  }

  Future<void> _onRead(
    CategoryEventReadData event,
    Emitter<CategoryState> emit,
  ) async {
    LoadingDialog.show();

    await FFirestoreUtils.categoryCollection.orderBy("name").get().then(
      (QuerySnapshot<Category> snapshot) {
        CacheManager.categories.clear();
        for (var doc in snapshot.docs) {
          CacheManager.categories.add(doc.data());
        }

        LoadingDialog.hide();
        if (event.readSuccess != null) {
          event.readSuccess!();
        }
      },
    ).catchError((error) {
      LoadingDialog.hide();
    });
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

    await FFirestoreUtils.categoryCollection
        .add(event.category)
        .then((_) => emit(CategoryStateCreateDataSuccess()))
        .catchError(
          (error) => emit(_dialogStateFail(message: error.toString())),
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

    await FFirestoreUtils.categoryCollection
        .doc(event.category.id)
        .update(event.category.toJson())
        .then((_) => emit(CategoryStateUpdateDataSuccess()))
        .catchError(
          (error) => emit(_dialogStateFail(message: error.toString())),
        );
  }

  Future<void> _onDelete(
    CategoryEventDeleteData event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryStateLoading());
    await FFirestoreUtils.categoryCollection
        .doc(event.categoryId)
        .delete()
        .then((_) => emit(CategoryStateDeleteDataSuccess()))
        .catchError(
          (error) => emit(_dialogStateFail(message: error.toString())),
        );
  }

  Future<void> _onSearch(
    CategoryEventSearch event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryStateSearch(query: event.query));
  }

  CategoryDialogStateFail _dialogStateFail(
          {required String message, int code = 1}) =>
      CategoryDialogStateFail(error: ErrorModel(message: message, code: code));
}
