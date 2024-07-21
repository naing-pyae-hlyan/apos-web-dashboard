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
  final _nameFn = FocusNode();
  final _descFn = FocusNode();

  void _onSave() {
    final Product product = Product(
      id: widget.product?.id,
      readableId: widget.product?.readableId ??
          idsGenerator(
            "PDT",
            CacheManager.products.length + 1,
          ),
      name: _nameTxtCtrl.text,
      image: "",
      description: _descTxtCtrl.text,
      price: 1,
      stockQuantity: 1,
      categoryId: "",
      categoryName: "",
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
    doAfterBuild(callback: () {
      _nameFn.requestFocus();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _nameTxtCtrl.dispose();
      _descTxtCtrl.dispose();
      _nameFn.dispose();
      _descFn.dispose();
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
        children: [
          MyInputField(
            controller: _nameTxtCtrl,
            hintText: "Enter Name",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          MyInputField(
            controller: _descTxtCtrl,
            hintText: "Enter Description",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          MyInputField(
            controller: _descTxtCtrl,
            hintText: "Enter Price",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          MyInputField(
            controller: _descTxtCtrl,
            hintText: "Enter Qty",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
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

            return MyButton(label: "Save", onPressed: _onSave);
          },
          listener: (_, ProductState state) {
            if (state is ProductStateCreateDataSuccess ||
                state is ProductStateUpdateDataSuccess) {
              context.pop();
            }

            if (state is ProductDialogStateFail) {
              if (state.error.code == 1) {
                _nameFn.requestFocus();
                return;
              }

              if (state.error.code == 2) {
                _descFn.requestFocus();
                return;
              }
            }
          },
        ),
      ],
    );
  }
}
