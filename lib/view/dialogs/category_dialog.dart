import 'package:apos/lib_exp.dart';

void showCategoryBlocDialog(BuildContext context, {Category? category}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _CategoryDialog(category: category),
    );

class _CategoryDialog extends StatefulWidget {
  final Category? category;
  const _CategoryDialog({this.category});

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  late CategoryBloc categoryBloc;

  final _nameTxtCtrl = TextEditingController();
  final _descTxtCtrl = TextEditingController();
  final _nameFn = FocusNode();
  final _descFn = FocusNode();

  void _onSave() {
    final name = _nameTxtCtrl.text;
    final description = _descTxtCtrl.text;
    final readableId = widget.category?.readableId ??
        RandomIdGenerator.getnerateCategoryUniqueId();

    final category = Category(
      id: widget.category?.id,
      readableId: readableId,
      name: name,
      description: description,
    );

    if (widget.category == null) {
      categoryBloc.add(CategoryEventCreateData(category: category));
    } else {
      categoryBloc.add(CategoryEventUpdateData(category: category));
    }
  }

  @override
  void initState() {
    categoryBloc = context.read<CategoryBloc>();

    super.initState();
    _nameTxtCtrl.text = widget.category?.name ?? '';
    _descTxtCtrl.text = widget.category?.description ?? '';
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
        children: [
          MyInputField(
            controller: _nameTxtCtrl,
            focusNode: _nameFn,
            title: "Category Name",
            hintText: "Enter Name",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          verticalHeight16,
          MyInputField(
            controller: _descTxtCtrl,
            focusNode: _descFn,
            title: "Category Description",
            hintText: "Enter Description",
            maxLines: 4,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _onSave(),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (_, state) {
              if (state is CategoryDialogStateFail) {
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
