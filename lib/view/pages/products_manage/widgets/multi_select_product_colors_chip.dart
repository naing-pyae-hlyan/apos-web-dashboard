import 'package:apos/lib_exp.dart';

class MultiSelectProductColors extends StatefulWidget {
  final List<ProductColors> productColors;
  final List<int> oldHexColors;
  final Function(List<String>) onSelectedColors;
  const MultiSelectProductColors({
    super.key,
    required this.productColors,
    required this.oldHexColors,
    required this.onSelectedColors,
  });

  @override
  State<MultiSelectProductColors> createState() =>
      _MultiSelectProductColorsState();
}

class _MultiSelectProductColorsState extends State<MultiSelectProductColors> {
  final List<String> selectedColorNames = [];

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
          selected: selectedColorNames.contains(productColor.name),
          onSelected: (bool selected) {
            setState(() {
              selectedColorNames.contains(productColor.name)
                  ? selectedColorNames.remove(productColor.name)
                  : selectedColorNames.add(productColor.name);
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
    for (final int hexValue in widget.oldHexColors) {
      selectedColorNames.add(parseHexToProductColorName(hexValue));
    }
    super.initState();
  }

  @override
  void dispose() {
    selectedColorNames.clear();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MultiSelectProductColors oldWidget) {
    selectedColorNames.clear();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        verticalHeight16,
        myTitle("Available Colors", fontWeight: FontWeight.w800),
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
