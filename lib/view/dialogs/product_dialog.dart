import 'package:apos/lib_exp.dart';

void showProductBlocDialog(
  BuildContext context, {
  ProductModel? product,
  required bool isNewProduct,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AttachmentsBloc()),
          BlocProvider(create: (_) => CategoryChangeBloc()),
        ],
        child: _ProductDialog(product: product, isNewProduct: isNewProduct),
      ),
    );

const _productNameErrorKey = "product-name-error-key";
const _productPriceErrorKey = "product-price-error-key";
const _productCategoryDropdownErrorKey = "product-category-dropdown-error-key";

class _ProductDialog extends StatefulWidget {
  final ProductModel? product;
  final bool isNewProduct;
  const _ProductDialog({required this.product, required this.isNewProduct});

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  late ProductBloc productBloc;
  late CategoryChangeBloc categoryChangeBloc;
  late ErrorBloc errorBloc;
  late AttachmentsBloc attachmentsBloc;

  final _nameTxtCtrl = TextEditingController();
  final _descTxtCtrl = TextEditingController();
  final _priceTxtCtrl = TextEditingController();
  final _nameFn = FocusNode();
  final _descFn = FocusNode();
  final _priceFn = FocusNode();

  Future<void> _onSave() async {
    final name = _nameTxtCtrl.text;
    final descriptoin = _descTxtCtrl.text;
    final price = _priceTxtCtrl.text.forceDouble();
    final readableId = widget.product?.readableId ??
        RandomIdGenerator.getnerateProductUniqueId();
    final String? categoryId =
        categoryChangeBloc.selectedCategory?.id ?? widget.product?.categoryId;
    final String? categoryName = categoryChangeBloc.selectedCategory?.name ??
        widget.product?.categoryName;

    final product = ProductModel(
      id: widget.product?.id,
      readableId: readableId,
      name: name,
      base64Images: attachmentsBloc.state.base64Images,
      description: descriptoin,
      price: price,
      types: categoryChangeBloc.productSizesAsStrings,
      hexColors: categoryChangeBloc.productColorsAsHexs,
      categoryId: categoryId,
      categoryName: categoryName,
      topSalesCount: widget.product?.topSalesCount ?? 0,
    );
    if (widget.isNewProduct && widget.product == null) {
      productBloc.add(ProductEventCreateData(product: product));
    } else {
      bool checkTakenName = name != widget.product?.name;
      productBloc.add(ProductEventUpdateData(
        product: product,
        checkTakenName: checkTakenName,
      ));
    }
  }

  void _onSelectedSizes(List<ProductSizeModel> sizes) {
    categoryChangeBloc.add(CategoryChangeEventAddSizes(sizes));
  }

  void _onSelectedColors(List<ProductColorModel> colors) {
    categoryChangeBloc.add(CategoryChangeEventAddColors(colors));
  }

  void _onSelectedCategory(CategoryModel? category) {
    final selected = categoryChangeBloc.selectedCategory;
    if (selected?.id != null && selected?.id == category?.id) {
      return;
    }
    categoryChangeBloc.add(CategoryChangeEventSelectCategory(category));
  }

  @override
  void initState() {
    categoryChangeBloc = context.read<CategoryChangeBloc>();
    productBloc = context.read<ProductBloc>();
    errorBloc = context.read<ErrorBloc>();
    attachmentsBloc = context.read<AttachmentsBloc>();

    super.initState();

    _nameTxtCtrl.text = widget.product?.name ?? '';
    _descTxtCtrl.text =
        (widget.product?.description ?? '').replaceFirst("-", "");
    _priceTxtCtrl.text =
        widget.product?.price != null ? widget.product!.price.toString() : "";

    doAfterBuild(callback: () {
      categoryChangeBloc.add(CategoryChangeEventInit());
      errorBloc.add(ErrorEventResert());

      if (widget.product != null) {
        bool categoryIdIsNotNull = widget.product?.categoryId != null;
        final categories = CacheManager.categories;
        for (CategoryModel category in categories) {
          bool categoryIdIsSame = widget.product?.categoryId == category.id;
          if (categoryIdIsNotNull && categoryIdIsSame) {
            categoryChangeBloc.add(CategoryChangeEventSelectCategory(category));
            break;
          }
        }

        // For images
        if (widget.product?.base64Images.isNotEmpty == true) {
          attachmentsBloc.add(AttachmentsEventSetImages(
            base64Images: widget.product?.base64Images ?? [],
          ));
        }
      }
      _nameFn.requestFocus();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _nameTxtCtrl.dispose();
      _descTxtCtrl.dispose();
      _priceTxtCtrl.dispose();
      _nameFn.dispose();
      _descFn.dispose();
      _priceFn.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = context.screenWidth * 0.7;
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Consts.secondaryColor,
      title: Column(
        children: [
          myTitle(
            widget.isNewProduct ? 'Add Product' : 'Edit Product',
          ),
          if (widget.product?.id != null) ...[
            verticalHeight4,
            myText(widget.product?.id),
          ],
        ],
      ),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<CategoryChangeBloc, CategoryChangeState>(
                buildWhen: (previous, current) =>
                    current is CategoryChangeStateSelectedCategory,
                builder: (_, state) {
                  return CategoryDropdown(
                    key: UniqueKey(),
                    title: "Category",
                    errorKey: _productCategoryDropdownErrorKey,
                    value: categoryChangeBloc.selectedCategory,
                    categories: <CategoryModel>[
                      ...CacheManager.categories,
                    ]..insert(0, CategoryModel.selectCategoriesValue),
                    onSelectedCategory: _onSelectedCategory,
                  );
                },
              ),
              verticalHeight16,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: dialogWidth * 0.5,
                    child: MyInputField(
                      controller: _nameTxtCtrl,
                      focusNode: _nameFn,
                      title: "Product Name",
                      hintText: "Enter Name",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      errorKey: _productNameErrorKey,
                    ),
                  ),
                  horizontalWidth16,
                  SizedBox(
                    width: dialogWidth * 0.5 - 16,
                    child: MyInputField(
                      controller: _priceTxtCtrl,
                      focusNode: _priceFn,
                      title: "Price",
                      hintText: "Enter Price",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      errorKey: _productPriceErrorKey,
                    ),
                  ),
                ],
              ),
              verticalHeight16,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: dialogWidth * 0.5,
                    child: MyInputField(
                      controller: _descTxtCtrl,
                      focusNode: _descFn,
                      title: "Product Description",
                      hintText: "Enter Description",
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      errorKey: null,
                    ),
                  ),
                  horizontalWidth16,
                  ProductImagesWidget(
                    contentWidth: dialogWidth * 0.5 - 16,
                  ),
                ],
              ),
              BlocBuilder<CategoryChangeBloc, CategoryChangeState>(
                builder: (_, state) {
                  final CategoryModel? selected =
                      categoryChangeBloc.selectedCategory;
                  final categorySizes = categoryChangeBloc.categorySizes;
                  final categoryHexColors =
                      categoryChangeBloc.categoryHexColors;
                  List<String> oldSizes = [];
                  List<int> oldHexColors = [];
                  if (widget.product?.categoryId == selected?.id) {
                    oldSizes = widget.product?.types ?? [];
                    oldHexColors = widget.product?.hexColors ?? [];
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (categorySizes.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: MultiSelectProductSizes(
                            // key: UniqueKey(),
                            allSizes: categorySizes,
                            oldSizes: oldSizes,
                            onSelectedSizes: _onSelectedSizes,
                          ),
                        ),
                      if (categoryHexColors.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: MultiSelectProductColors(
                            // key: UniqueKey(),
                            allHexColors: categoryHexColors,
                            oldHexColors: oldHexColors,
                            onSelectedColors: _onSelectedColors,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: myText('Cancel'),
        ),
        BlocConsumer<ProductBloc, ProductState>(
          builder: (_, ProductState state) {
            if (state is ProductDialogStateLoading) {
              return const MyCircularIndicator();
            }

            return MyButton(
              label: "Save",
              icon: Icons.save,
              onPressed: _onSave,
            );
          },
          listener: (_, ProductState state) {
            if (state is ProductStateCreateDataSuccess ||
                state is ProductStateUpdateDataSuccess) {
              context.pop();
            }

            if (state is ProductDialogStateFail) {
              switch (state.error.code) {
                case 1:
                  errorBloc.add(ErrorEventSetError(
                    errorKey: _productNameErrorKey,
                    error: state.error,
                  ));
                  _nameFn.requestFocus();
                  break;
                case 2:
                  errorBloc.add(ErrorEventSetError(
                    errorKey: _productPriceErrorKey,
                    error: state.error,
                  ));
                  _priceFn.requestFocus();
                  break;
                case 3:
                  errorBloc.add(ErrorEventSetError(
                    errorKey: _productCategoryDropdownErrorKey,
                    error: state.error,
                  ));
                  _priceFn.requestFocus();
                  break;
              }
            }
          },
        ),
      ],
    );
  }
}
