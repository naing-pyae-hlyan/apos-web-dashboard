import 'package:apos/lib_exp.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CollectionReference _productRef;
  ProductBloc({required FirebaseFirestore database})
      : _productRef = database.collection("product").withConverter<Product>(
              fromFirestore: (snapshot, _) => Product.fromJson(
                snapshot.data()!,
                snapshot.id,
              ),
              toFirestore: (product, _) => product.toJson(),
            ),
        super(ProductStateInitial()) {
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
      emit(_dialogStateFail(message: "Enter product name"));
      return;
    }

    // TODO validate

    var same = CacheManager.products.where(
      (Product product) => product.name == event.product.name,
    );
    if (same.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Name is already taken"));
      return;
    }

    await _productRef
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
      emit(_dialogStateFail(message: "Enter product name"));
      return;
    }

    // TODO validate

    var same = CacheManager.products.where(
      (Product product) => product.name == event.product.name,
    );
    if (same.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(_dialogStateFail(message: "Name is already taken"));
      return;
    }

    await _productRef
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

    await _productRef
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
