import 'package:apos/lib_exp.dart';

class CaetgoryDropdown extends StatefulWidget {
  final Function(Category?) onSelectedCategory;
  const CaetgoryDropdown({
    super.key,
    required this.onSelectedCategory,
  });

  @override
  State<CaetgoryDropdown> createState() => _CaetgoryDropdownState();
}

class _CaetgoryDropdownState extends State<CaetgoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
      padding: EdgeInsets.zero,
      items: CacheManager.categories.map((Category category) {
        return DropdownMenuItem<Category>(
          child: myText(category.name),
        );
      }).toList(),
      onChanged: (a) {},
    );
  }
}
