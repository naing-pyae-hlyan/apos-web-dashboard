import 'package:apos/lib_exp.dart';

class MultiSelectProductColors extends StatefulWidget {
  final String? title;
  final List<ProductColors> productColors;
  final List<int> oldHexColors;
  final Function(List<ProductColors>) onSelectedColors;
  const MultiSelectProductColors({
    super.key,
    this.title,
    required this.productColors,
    required this.oldHexColors,
    required this.onSelectedColors,
  });

  @override
  State<MultiSelectProductColors> createState() =>
      _MultiSelectProductColorsState();
}

class _MultiSelectProductColorsState extends State<MultiSelectProductColors> {
  final List<ProductColors> selectedColorNames = [];

  List<Widget> _buildColorList() {
    List<Widget> choices = [];
    for (final ProductColors productColor in widget.productColors) {
      choices.add(
        ChoiceChip(
          avatar: CircleAvatar(
            backgroundColor: Color(productColor.hex),
          ),
          checkmarkColor: Colors.white,
          label: myText(productColor.name),
          selected: selectedColorNames.contains(productColor),
          onSelected: (bool selected) {
            setState(() {
              selectedColorNames.contains(productColor)
                  ? selectedColorNames.remove(productColor)
                  : selectedColorNames.add(productColor);
            });
            widget.onSelectedColors(selectedColorNames);
          },
        ),
      );
    }
    return choices;
  }

  @override
  void initState() {
    selectedColorNames.clear();
    selectedColorNames.addAll(parseHexsToProductColors(widget.oldHexColors));
    super.initState();
  }

  @override
  void dispose() {
    selectedColorNames.clear();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MultiSelectProductColors oldWidget) {
    // selectedColorNames.clear();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_buildColorList().isEmpty) return emptyUI;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        myText(widget.title ?? "Available Colors", fontWeight: FontWeight.w800),
        verticalHeight8,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _buildColorList(),
        ),
      ],
    );
  }
}
