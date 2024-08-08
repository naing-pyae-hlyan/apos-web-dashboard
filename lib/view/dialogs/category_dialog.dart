import 'package:apos/lib_exp.dart';

void showCategoryBlocDialog(
  BuildContext context, {
  CategoryModel? category,
  required bool isNewCategory,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _CategoryDialog(
        category: category,
        isNewCategory: isNewCategory,
      ),
    );

const _categoryNameErrorKey = "category-name-error-key";

class _CategoryDialog extends StatefulWidget {
  final CategoryModel? category;
  final bool isNewCategory;
  const _CategoryDialog({required this.category, required this.isNewCategory});

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

  List<ProductColorModel> _colors = [];

  void _onSave() {
    final name = _nameTxtCtrl.text;
    final readableId = widget.category?.readableId ??
        RandomIdGenerator.getnerateCategoryUniqueId();
    final List<String> sizes = _sizeTxtCtrl.text.split(",");
    sizes.removeWhere((String str) => str.isEmpty || str == "-");
    if (sizes.isNotEmpty && sizes.first.isEmpty) {
      sizes.clear();
    }

    final category = CategoryModel(
      id: widget.category?.id,
      readableId: readableId,
      name: name,
      sizes: sizes,
      colorHexs: ProductColorModel.parseProductColorsToHexs(_colors),
    );

    if (widget.isNewCategory && widget.category == null) {
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
    _sizeTxtCtrl.text =
        (widget.category?.sizes ?? []).join(",").replaceAll("-", "");
    _colors = ProductColorModel.parseHexsToProductColors(
      widget.category?.colorHexs ?? [],
    );
    doAfterBuild(callback: () {
      _nameFn.requestFocus();
      errorBloc.add(ErrorEventResert());
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
            allHexColors: ProductColorModel.getAllProductColorHexs(),
            oldHexColors: widget.category?.colorHexs ?? [],
            onSelectedColors: (List<ProductColorModel> colors) {
              _colors = colors;
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
