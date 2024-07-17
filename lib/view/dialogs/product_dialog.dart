import 'package:apos/lib_exp.dart';

void showProductDialog(
  BuildContext context, {
  Product? product,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => ProductDialog(product: product),
    );

class ProductDialog extends StatefulWidget {
  final Product? product;
  const ProductDialog({super.key, this.product});

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  late ProductBloc productBloc;

  final _formKey = GlobalKey<FormState>();

  final _nameTxtCtrl = TextEditingController();
  final _descTxtCtrl = TextEditingController();

  @override
  void initState() {
    productBloc = context.read<ProductBloc>();

    super.initState();
    _nameTxtCtrl.text = widget.product?.name ?? '';
    _descTxtCtrl.text = widget.product?.description ?? '';
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
      content: Form(
        key: _formKey,
        child: Column(
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: myText('Cancel'),
        ),
        MyButton(
          label: "Save",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              String? id = widget.product?.id;

              final product = Product(
                id: id ?? DateTime.now().toIso8601String(),
                name: _nameTxtCtrl.text,
                description: _descTxtCtrl.text,
                price: 1,
                stockQuantity: 1,
                image: "",
                categoryId: "",
                categoryName: "",
              );
              if (widget.product == null) {
                productBloc.add(ProductEventCreateData(product: product));
              } else {
                productBloc.add(ProductEventUpdateData(product: product));
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
