import 'package:apos/lib_exp.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductStateInitial(products: [])) {
    on<ProductEventCreateData>(_onCreate);
    on<ProductEventReadData>(_onRead);
    on<ProductEventUpdateData>(_onUpdate);
    on<ProductEventDeleteData>(_onDelete);
  }

  Future<void> _onCreate(
    ProductEventCreateData event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading(products: state.products));

    CacheManager.products.add(event.product);
    emit(ProductStateCreateDataSuccess(products: CacheManager.products));
  }

  Future<void> _onRead(
    ProductEventReadData event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading(products: state.products));

    List<Product> products = List.generate(26, (index) => tempProduct(index));

    //
    CacheManager.products = products;

    emit(ProductStateReadDataSuccess(products: products));
  }

  Future<void> _onUpdate(
    ProductEventUpdateData event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading(products: state.products));

    for (Product product in CacheManager.products) {
      if (product.id == event.product.id) {
        product = Product(
          id: event.product.id,
          name: event.product.name,
          description: event.product.description,
          image: event.product.image,
          price: event.product.price,
          stockQuantity: event.product.stockQuantity,
          categoryId: event.product.categoryId,
          categoryName: event.product.categoryName,
        );
      }
    }
    emit(ProductStateUpdateDataSuccess(products: CacheManager.products));
  }

  Future<void> _onDelete(
    ProductEventDeleteData event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductStateLoading(products: state.products));

    List<Product> products = CacheManager.products;
    products.removeWhere(
      (Product product) => event.productId == product.id,
    );
    CacheManager.products = products;

    emit(ProductStateDeleteDataSuccess(products: products));
  }
}
