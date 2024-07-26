import 'dart:async';
import 'package:apos/lib_exp.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductStateInitial()) {
    on<ProductEventCreateData>(_onCreate);
    on<ProductEventUpdateData>(_onUpdate);
    on<ProductEventDeleteData>(_onDelete);
    on<ProductEventSearch>(_onSearch);
  }

  Future<void> _onCreate(
    ProductEventCreateData event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductDialogStateLoading());
    if (event.product.name.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter product name", code: 1));
      return;
    }

    if (event.product.price == 0.0) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter price", code: 3));
      return;
    }

    if (event.product.stockQuantity == 0) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter qty", code: 4));
      return;
    }

    if (event.product.categoryId == null ||
        event.product.categoryName == null) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Select Category"));
      return;
    }

    var same = CacheManager.products.where(
      (Product product) => product.name == event.product.name,
    );
    if (same.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Name is already taken", code: 1));
      return;
    }

    await FFirestoreUtils.productCollection
        .add(event.product)
        .then((_) => emit(ProductStateCreateDataSuccess()))
        .catchError(
          (error) => emit(_dialogStateFail(message: error.toString())),
        );
  }

  Future<void> _onUpdate(
    ProductEventUpdateData event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductDialogStateLoading());
    if (event.product.name.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter product name", code: 1));
      return;
    }

    if (event.product.price == 0.0) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter price", code: 3));
      return;
    }

    if (event.product.stockQuantity == 0) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Enter qty", code: 4));
      return;
    }

    if (event.product.categoryId == null ||
        event.product.categoryName == null) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Select Category"));
      return;
    }

    if (event.checkTakenName) {
      var same = CacheManager.products.where(
        (Product product) => product.name == event.product.name,
      );

      if (same.isNotEmpty) {
        await Future.delayed(const Duration(milliseconds: 500));
        emit(_dialogStateFail(message: "Name is already taken", code: 1));
        return;
      }
    }

    await FFirestoreUtils.productCollection
        .doc(event.product.id)
        .update(event.product.toJson())
        .then((_) => emit(ProductStateUpdateDataSuccess()))
        .catchError(
          (error) => emit(_dialogStateFail(message: error.toString())),
        );
  }

  Future<void> _onDelete(
    ProductEventDeleteData event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading());

    await FFirestoreUtils.productCollection
        .doc(event.productId)
        .delete()
        .then((_) => emit(ProductStateDeleteDataSuccess()))
        .catchError(
          (error) => emit(_dialogStateFail(message: error.toString())),
        );
  }

  Future<void> _onSearch(
    ProductEventSearch event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateSearch(query: event.query));
  }

  ProductDialogStateFail _dialogStateFail(
          {required String message, int code = 1}) =>
      ProductDialogStateFail(error: ErrorModel(message: message, code: code));
}
