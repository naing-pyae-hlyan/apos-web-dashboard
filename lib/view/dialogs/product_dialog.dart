import 'package:apos/lib_exp.dart';

void showProductBlocDialog(
  BuildContext context, {
  Product? product,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AttachmentsBloc()),
        ],
        child: _ProductDialog(product: product),
      ),
    );

const _productNameErrorKey = "product-name-error-key";
const _productDescErrorKey = "product-desc-error-key";
const _productPriceErrorKey = "product-price-error-key";

class _ProductDialog extends StatefulWidget {
  final Product? product;
  const _ProductDialog({this.product});

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  late ProductBloc productBloc;
  late AttachmentsBloc attachmentsBloc;

  final _nameTxtCtrl = TextEditingController();
  final _descTxtCtrl = TextEditingController();
  final _priceTxtCtrl = TextEditingController();
  final _nameFn = FocusNode();
  final _descFn = FocusNode();
  final _priceFn = FocusNode();

  Category? _selectedCategory;

  final ValueNotifier<List<String>> _sizesListener = ValueNotifier([]);
  final ValueNotifier<List<ProductColors>> _colorsListener = ValueNotifier([]);

  Future<void> _onSave() async {
    final name = _nameTxtCtrl.text;
    final descriptoin = _descTxtCtrl.text;
    final price = _priceTxtCtrl.text.forceDouble();
    final readableId = widget.product?.readableId ??
        RandomIdGenerator.getnerateProductUniqueId();
    final String? categoryId =
        _selectedCategory?.id ?? widget.product?.categoryId;
    final String? categoryName =
        _selectedCategory?.name ?? widget.product?.categoryName;

    final product = Product(
      id: widget.product?.id,
      readableId: readableId,
      name: name,
      base64Images: attachmentsBloc.state.base64Images,
      description: descriptoin,
      price: price,
      sizes: _sizesListener.value,
      hexColors: parseProductColorsToHexs(_colorsListener.value),
      categoryId: categoryId,
      categoryName: categoryName,
      topSalesCount: widget.product?.topSalesCount ?? 0,
    );
    if (widget.product == null) {
      productBloc.add(ProductEventCreateData(product: product));
    } else {
      bool checkTakenName = name != widget.product?.name;
      productBloc.add(ProductEventUpdateData(
        product: product,
        checkTakenName: checkTakenName,
      ));
    }
  }

  @override
  void initState() {
    productBloc = context.read<ProductBloc>();
    attachmentsBloc = context.read<AttachmentsBloc>();

    super.initState();
    _nameTxtCtrl.text = widget.product?.name ?? '';
    _descTxtCtrl.text = widget.product?.description ?? '';
    _priceTxtCtrl.text =
        widget.product?.price != null ? widget.product!.price.toString() : "";

    if (widget.product?.categoryId != null &&
        widget.product?.categoryName != null) {
      final categories = CacheManager.categories;
      for (Category category in categories) {
        if (category.id == widget.product?.categoryId) {
          _selectedCategory = category;

          break;
        }
      }
    }

    doAfterBuild(callback: () {
      if (widget.product?.base64Images.isNotEmpty == true) {
        attachmentsBloc.add(AttachmentsEventSetImages(
          base64Images: widget.product?.base64Images ?? [],
        ));
      }

      if (_selectedCategory != null) {
        if (_selectedCategory!.sizes.isNotEmpty) {
          _sizesListener.value = _selectedCategory?.sizes ?? [];
        }
        if (_selectedCategory!.colorHexs.isNotEmpty) {
          _colorsListener.value = parseHexsToProductColors(
            _selectedCategory?.colorHexs ?? [],
          );
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
            widget.product == null ? 'Add Product' : 'Edit Product',
          ),
          if (widget.product?.id != null) ...[
            verticalHeight4,
            myText(widget.product?.id),
          ],
        ],
      ),
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryDropdown(
              title: "Category",
              value: _selectedCategory,
              categories: <Category>[
                ...CacheManager.categories,
              ]..insert(0, Category.selectCategoriesValue),
              onSelectedCategory: (Category? category) {
                if (_selectedCategory?.id == category?.id) return;
                _selectedCategory = category;
                _sizesListener.value = category?.sizes ?? [];
                _colorsListener.value = parseHexsToProductColors(
                  category?.colorHexs ?? [],
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
                    errorKey: _productDescErrorKey,
                  ),
                ),
                horizontalWidth16,
                ProductImagesWidget(
                  contentWidth: dialogWidth * 0.5 - 16,
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _sizesListener,
              builder: (_, List<String> sizes, __) {
                if (sizes.isEmpty) return emptyUI;
                List<String> oldSize = [];
                if (widget.product?.categoryId == _selectedCategory?.id) {
                  oldSize = widget.product?.sizes ?? [];
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: MultiSelectProductSizes(
                    sizes: _selectedCategory?.sizes ?? [],
                    oldSizes: oldSize,
                    onSelectedSizes: (List<String> sizes) {
                      _sizesListener.value = sizes;
                    },
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _colorsListener,
              builder: (_, List<ProductColors> colorList, __) {
                if (colorList.isEmpty) return emptyUI;
                List<int> oldSize = [];
                if (widget.product?.categoryId == _selectedCategory?.id) {
                  oldSize = widget.product?.hexColors ?? [];
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: MultiSelectProductColors(
                    productColors: parseHexsToProductColors(
                      _selectedCategory?.colorHexs ?? [],
                    ),
                    oldHexColors: oldSize,
                    onSelectedColors: (List<ProductColors> colors) {
                      _colorsListener.value = colors;
                    },
                  ),
                );
              },
            ),
            verticalHeight16,
            BlocBuilder<ProductBloc, ProductState>(
              builder: (_, state) {
                if (state is ProductDialogStateFail) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: errorText(state.error),
                    ),
                  );
                }
                return emptyUI;
              },
            ),
          ],
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
                  _nameFn.requestFocus();
                  break;
                case 2:
                  _descFn.requestFocus();
                  break;
                case 3:
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
