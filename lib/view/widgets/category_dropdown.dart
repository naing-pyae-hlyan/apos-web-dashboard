import 'package:apos/lib_exp.dart';

class CategoryDropdown extends StatefulWidget {
  final String? title;
  final CategoryModel? value;
  final List<CategoryModel> categories;
  final Function(CategoryModel?) onSelectedCategory;
  final String? errorKey;
  const CategoryDropdown({
    super.key,
    this.title,
    this.value,
    required this.categories,
    required this.onSelectedCategory,
    required this.errorKey,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late CategoryModel dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.value ?? widget.categories.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdown = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Consts.primaryColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: DropdownButton<CategoryModel>(
        padding: EdgeInsets.zero,
        isDense: true,
        value: dropdownValue,
        dropdownColor: Colors.white,
        iconEnabledColor: Consts.primaryColor,
        iconDisabledColor: Consts.primaryColor,
        focusColor: Colors.transparent,
        underline: emptyUI,
        borderRadius: BorderRadius.circular(4),
        elevation: 16,
        items: widget.categories.map((CategoryModel category) {
          return DropdownMenuItem<CategoryModel>(
            value: category,
            child: myText(category.name, fontWeight: FontWeight.w800),
          );
        }).toList(),
        onChanged: (CategoryModel? category) {
          if (category != null) {
            setState(() {
              dropdownValue = category;
            });

            widget.onSelectedCategory(
              category.isDropdownTitle ? null : category,
            );
          }
        },
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          myText(widget.title, fontWeight: FontWeight.w800),
          verticalHeight8,
        ],
        dropdown,
        if (widget.errorKey != null)
          BlocBuilder<ErrorBloc, ErrorState>(
            builder: (_, state) {
              if (state is ErrorStateHasError) {
                if (state.errorKey == widget.errorKey) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: errorText(state.error.message),
                  );
                }
              }
              return emptyUI;
            },
          ),
      ],
    );
  }
}
