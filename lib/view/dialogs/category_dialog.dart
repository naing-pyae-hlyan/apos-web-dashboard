import 'package:apos/lib_exp.dart';

void showCategoryDialog(BuildContext context, {Category? category}) =>
    showAdaptiveDialog(
      context: context,
      builder: (_) => CategoryDialog(category: category),
    );

class CategoryDialog extends StatefulWidget {
  final Category? category;
  const CategoryDialog({super.key, this.category});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  late CategoryBloc categoryBloc;

  final _formKey = GlobalKey<FormState>();

  final _nameTxtCtrl = TextEditingController();
  final _descTxtCtrl = TextEditingController();

  @override
  void initState() {
    categoryBloc = context.read<CategoryBloc>();

    super.initState();
    _nameTxtCtrl.text = widget.category?.name ?? '';
    _descTxtCtrl.text = widget.category?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          myTitle(
            widget.category == null ? 'Add Category' : 'Edit Category',
          ),
          if (widget.category?.id != null) ...[
            verticalHeight4,
            myText(widget.category?.id),
          ],
        ],
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

              String? id = widget.category?.id;

              final category = Category(
                id: id ?? DateTime.now().toIso8601String(),
                name: _nameTxtCtrl.text,
                description: _descTxtCtrl.text,
              );
              if (widget.category == null) {
                categoryBloc.add(CategoryEventCreateData(category: category));
              } else {
                categoryBloc.add(CategoryEventUpdateData(category: category));
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
