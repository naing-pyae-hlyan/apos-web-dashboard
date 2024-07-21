import 'package:apos/lib_exp.dart';

void showProductBlocDialog(
  BuildContext context, {
  Product? product,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _ProductDialog(product: product),
    );

class _ProductDialog extends StatefulWidget {
  final Product? product;
  const _ProductDialog({this.product});

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  late ProductBloc productBloc;

  final _nameTxtCtrl = TextEditingController();
  final _descTxtCtrl = TextEditingController();
  final _priceTxtCtrl = TextEditingController();
  final _qtyTxtCtrl = TextEditingController();
  final _nameFn = FocusNode();
  final _descFn = FocusNode();
  final _priceFn = FocusNode();
  final _qtyFn = FocusNode();

  Category? _selectedCategory;

  void _onSave() {
    final name = _nameTxtCtrl.text;
    final descriptoin = _descTxtCtrl.text;
    final price = _priceTxtCtrl.text.forceDouble();
    final qty = _qtyTxtCtrl.text.forceInt();
    final readableId = widget.product?.readableId ??
        idsGenerator("PDT", CacheManager.products.length + 1);

    final Product product = Product(
      id: widget.product?.id,
      readableId: readableId,
      name: name,
      image: "",
      description: descriptoin,
      price: price,
      stockQuantity: qty,
      categoryId: _selectedCategory?.id,
      categoryName: _selectedCategory?.name,
    );
    if (widget.product == null) {
      productBloc.add(ProductEventCreateData(product: product));
    } else {
      productBloc.add(ProductEventUpdateData(product: product));
    }
  }

  @override
  void initState() {
    productBloc = context.read<ProductBloc>();

    super.initState();
    _nameTxtCtrl.text = widget.product?.name ?? '';
    _descTxtCtrl.text = widget.product?.description ?? '';
    _priceTxtCtrl.text =
        widget.product?.price != null ? widget.product!.price.toString() : "";
    _qtyTxtCtrl.text = widget.product?.stockQuantity != null
        ? widget.product!.stockQuantity.toString()
        : "";
    doAfterBuild(callback: () {
      _nameFn.requestFocus();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _nameTxtCtrl.dispose();
      _descTxtCtrl.dispose();
      _priceTxtCtrl.dispose();
      _qtyTxtCtrl.dispose();
      _nameFn.dispose();
      _descFn.dispose();
      _priceFn.dispose();
      _qtyFn.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Consts.secondaryColor,
      title: SizedBox(
        width: context.screenWidth * 0.3,
        child: Column(
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
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyInputField(
            controller: _nameTxtCtrl,
            focusNode: _nameFn,
            title: "Product Name",
            hintText: "Enter Name",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          MyInputField(
            controller: _descTxtCtrl,
            focusNode: _descFn,
            title: "Product Description",
            hintText: "Enter Description",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          MyInputField(
            controller: _priceTxtCtrl,
            focusNode: _priceFn,
            title: "Price",
            hintText: "Enter Price",
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          MyInputField(
            controller: _qtyTxtCtrl,
            focusNode: _qtyFn,
            title: "Quantity",
            hintText: "Enter Qty",
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddImageWidget(
                pickedImage: (AttachmentFile? file) {},
              ),
              horizontalWidth8,
              CategoryDropdown(
                title: "Category",
                onSelectedCategory: (Category? category) {
                  _selectedCategory = category;
                },
              ),
            ],
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (_, state) {
              if (state is ProductDialogStateFail) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: myText(
                      "Error: ${state.error.message}",
                      color: Consts.errorColor,
                    ),
                  ),
                );
              }
              return emptyUI;
            },
          ),
        ],
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
                case 4:
                  _qtyFn.requestFocus();
                  break;
              }
            }
          },
        ),
      ],
    );
  }
}
