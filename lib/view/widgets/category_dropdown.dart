import 'package:apos/lib_exp.dart';

class CategoryDropdown extends StatefulWidget {
  final String? title;
  final Category? value;
  final bool defaultIsAll;
  final Function(Category?) onSelectedCategory;
  const CategoryDropdown({
    super.key,
    this.title,
    this.value,
    this.defaultIsAll = false,
    required this.onSelectedCategory,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  late Category dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.value ??
        Category.forDropdown(
          defaultIsAll: widget.defaultIsAll,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = CacheManager.dropdownCategories(
      defaultIsAll: widget.defaultIsAll,
    );

    final dropdown = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Consts.primaryColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: DropdownButton<Category>(
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
        items: categories.map((Category category) {
          return DropdownMenuItem<Category>(
            value: category,
            child: myText(category.name, fontWeight: FontWeight.w800),
          );
        }).toList(),
        onChanged: (Category? category) {
          if (category != null) {
            setState(() {
              dropdownValue = category;
            });

            widget
                .onSelectedCategory(category.isDropdownTitle ? null : category);
          }
        },
      ),
    );

    if (widget.title != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          myText(widget.title, fontWeight: FontWeight.w800),
          verticalHeight8,
          dropdown,
        ],
      );
    }
    return dropdown;
  }
}
