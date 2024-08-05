import 'package:apos/lib_exp.dart';

void showCategoryBlocDialog(BuildContext context, {Category? category}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _CategoryDialog(category: category),
    );

const _categoryNameErrorKey = "category-name-error-key";
const _categoryDescErrorKey = "category-desc-error-key";
const _categorySizesErrorKey = "category-sizes-error-key";

class _CategoryDialog extends StatefulWidget {
  final Category? category;
  const _CategoryDialog({this.category});

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  late CategoryBloc categoryBloc;

  final _nameTxtCtrl = TextEditingController();
  final _nameFn = FocusNode();
  final _sizeTxtCtrl = TextEditingController();
  final _sizeFn = FocusNode();
  final ValueNotifier<bool> _sizeListener = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _colorListener = ValueNotifier<bool>(false);

  void _onSave() {
    final name = _nameTxtCtrl.text;
    final readableId = widget.category?.readableId ??
        RandomIdGenerator.getnerateCategoryUniqueId();
    final hasSize = _sizeListener.value;
    final hasColor = _colorListener.value;

    final category = Category(
      id: widget.category?.id,
      readableId: readableId,
      name: name,
      hasSize: hasSize,
      hasColor: hasColor,
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

    super.initState();
    _nameTxtCtrl.text = widget.category?.name ?? '';
    doAfterBuild(callback: () {
      _nameFn.requestFocus();
      _sizeListener.value = widget.category?.hasSize ?? false;
      _colorListener.value = widget.category?.hasColor ?? false;
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
          myTitle("Tags"),
          const Divider(),
          verticalHeight8,
          ValueListenableBuilder(
            valueListenable: _sizeListener,
            builder: (_, __, ___) {
              return MyCheckBoxWithLabel(
                label: "Size",
                value: _sizeListener.value,
                mainAxisAlignment: MainAxisAlignment.end,
                onSelected: (bool select) {
                  _sizeListener.value = select;
                },
              );
            },
          ),
          verticalHeight16,
          ValueListenableBuilder(
            valueListenable: _colorListener,
            builder: (_, __, ___) {
              return MyCheckBoxWithLabel(
                label: "Color",
                value: _colorListener.value,
                mainAxisAlignment: MainAxisAlignment.end,
                onSelected: (bool select) {
                  _colorListener.value = select;
                },
              );
            },
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (_, state) {
              if (state is CategoryDialogStateFail) {
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
