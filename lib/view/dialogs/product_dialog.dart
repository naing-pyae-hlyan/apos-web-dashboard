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

  final ValueNotifier<bool> _hasSizeNotifier = ValueNotifier(false);
  final ValueNotifier<bool> _hasColorNotifier = ValueNotifier(false);

  final List<String> _sizes = [];
  final List<int> _hexColors = [];

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
      sizes: _selectedCategory?.hasSize == true ? _sizes : [],
      hexColors: _selectedCategory?.hasColor == true ? _hexColors : [],
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

  void onSelectedSizes(List<String> sizes) {
    _sizes.clear();
    _sizes.addAll(sizes);
  }

  /// colors must [Red, Orange, Yellow, Gren, Blue, Indigo, Violet]
  void onSelectedColors(List<String> colorNames) {
    _hexColors.clear();
    for (var colorName in colorNames) {
      _hexColors.add(parseProductColorNameToHex(colorName));
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
        if (_selectedCategory!.hasSize) {
          _sizes.clear();
          _sizes.addAll(widget.product?.sizes ?? []);
          _hasSizeNotifier.value = true;
        }
        if (_selectedCategory!.hasColor) {
          _hexColors.clear();
          for (final int hexValue in widget.product?.hexColors ?? []) {
            _hexColors.add(hexValue);
          }
          _hasColorNotifier.value = true;
        }
      }
      _nameFn.requestFocus();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _sizes.clear();
      _hexColors.clear();
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
                final hasSize = category?.hasSize ?? false;
                final hasColor = category?.hasColor ?? false;

                if (hasSize) _sizes.clear();
                if (hasColor) _hexColors.clear();

                if (hasSize == _hasSizeNotifier.value) {
                  _hasSizeNotifier.value = !hasSize;
                }
                if (hasColor == _hasColorNotifier.value) {
                  _hasColorNotifier.value = !hasColor;
                }
                _hasSizeNotifier.value = hasSize;
                _hasColorNotifier.value = hasColor;
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
              valueListenable: _hasSizeNotifier,
              builder: (_, bool value, ___) {
                if (!value) return emptyUI;

                return MultiSelectProductSizes(
                  sizes: Consts.productSizes,
                  oldSizes: widget.product?.sizes ?? [],
                  onSelectedSizes: onSelectedSizes,
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: _hasColorNotifier,
              builder: (_, bool value, ___) {
                if (!value) return emptyUI;

                return MultiSelectProductColors(
                  productColors: ProductColors.values,
                  oldHexColors: widget.product?.hexColors ?? [],
                  onSelectedColors: onSelectedColors,
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
