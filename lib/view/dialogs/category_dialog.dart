import 'package:apos/lib_exp.dart';

void showCategoryBlocDialog(BuildContext context, {Category? category}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _CategoryDialog(category: category),
    );

const _categoryNameErrorKey = "category-name-error-key";

class _CategoryDialog extends StatefulWidget {
  final Category? category;
  const _CategoryDialog({this.category});

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  late CategoryBloc categoryBloc;
  late ErrorBloc errorBloc;

  final _nameTxtCtrl = TextEditingController();
  final _nameFn = FocusNode();
  final _sizeTxtCtrl = TextEditingController();
  final _sizeFn = FocusNode();
  
  List<ProductColors> _colors = [];


  void _onSave() {
    final name = _nameTxtCtrl.text;
    final readableId = widget.category?.readableId ??
        RandomIdGenerator.getnerateCategoryUniqueId();
    final List<String> sizes = _sizeTxtCtrl.text.split(",");

    final category = Category(
      id: widget.category?.id,
      readableId: readableId,
      name: name,
      sizes: sizes,
      colorHexs: parseProductColorsToHexs(_colors),
    );

    if (widget.category == null) {
      categoryBloc.add(CategoryEventCreateData(category: category));
    } else {
      categoryBloc.add(CategoryEventUpdateData(
        currentCategoryName: widget.category!.name,
        category: category,
      ));
    }
  }

  @override
  void initState() {
    categoryBloc = context.read<CategoryBloc>();
    errorBloc = context.read<ErrorBloc>();

    super.initState();
    _nameTxtCtrl.text = widget.category?.name ?? '';
    _sizeTxtCtrl.text = (widget.category?.sizes ?? []).join(",");
    _colors = parseHexsToProductColors(widget.category?.colorHexs ?? []);
    doAfterBuild(callback: () {
      _nameFn.requestFocus();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _nameTxtCtrl.dispose();
      _nameFn.dispose();
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
              widget.category == null ? 'Add Category' : 'Edit Category',
            ),
            if (widget.category?.name != null) ...[
              verticalHeight4,
              myText(widget.category?.name),
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
            title: "Category Name",
            hintText: "Enter Name",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            errorKey: _categoryNameErrorKey,
          ),
          verticalHeight16,
          MyInputField(
            controller: _sizeTxtCtrl,
            focusNode: _sizeFn,
            title: "Sizes (Optional)",
            hintText: "Eg. S,M,L,XL,XXL",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            errorKey: null,
          ),
          verticalHeight16,
          MultiSelectProductColors(
            title: "Colors (Optional)",
            productColors: ProductColors.values,
            oldHexColors: widget.category?.colorHexs ?? [],
            onSelectedColors: (s) {
              _colors = s;
            },
          ),
          verticalHeight16,
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: myText('Cancel'),
        ),
        BlocConsumer<CategoryBloc, CategoryState>(
          builder: (_, CategoryState state) {
            if (state is CategoryDialogStateLoading) {
              return const MyCircularIndicator();
            }

            return MyButton(
              label: "Save",
              icon: Icons.save,
              onPressed: _onSave,
            );
          },
          listener: (_, CategoryState state) {
            if (state is CategoryStateCreateDataSuccess ||
                state is CategoryStateUpdateDataSuccess) {
              context.pop();
            }

            if (state is CategoryDialogStateFail) {
              if (state.error.code == 1) {
                _nameFn.requestFocus();
                errorBloc.add(
                  ErrorEventSetError(
                      errorKey: _categoryNameErrorKey, error: state.error),
                );
                return;
              }

              if (state.error.code == 2) {
                // _descFn.requestFocus();
                return;
              }
            }
          },
        ),
      ],
    );
  }
}
