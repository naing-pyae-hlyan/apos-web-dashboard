import 'package:apos/lib_exp.dart';

class MultiSelectProductColors extends StatefulWidget {
  final String? title;
  final List<int> allHexColors;
  final List<int> oldHexColors;
  final Function(List<ProductColor>) onSelectedColors;
  const MultiSelectProductColors({
    super.key,
    this.title,
    required this.allHexColors,
    required this.oldHexColors,
    required this.onSelectedColors,
  });

  @override
  State<MultiSelectProductColors> createState() =>
      _MultiSelectProductColorsState();
}

class _MultiSelectProductColorsState extends State<MultiSelectProductColors> {
  final List<ProductColor> selectedColors = [];

  List<Widget> _buildColorList() {
    List<Widget> choices = [];
    for (ProductColor pc in selectedColors) {
      choices.add(
        ChoiceChip(
          avatar: CircleAvatar(
            backgroundColor: Color(pc.hex),
          ),
          checkmarkColor: Colors.white,
          label: myText(pc.name),
          selected: pc.status,
          onSelected: (bool selected) {
            setState(() {
              pc.status = selected;
            });
            final List<ProductColor> onSelectedColors =
                selectedColors.where((ProductColor pc) => pc.status).toList();
            widget.onSelectedColors(onSelectedColors);
          },
        ),
      );
    }
    return choices;
  }

  @override
  void initState() {
    selectedColors.clear();
    selectedColors.addAll(
      ProductColor.parseHexsToAllProductColors(
        hexs: widget.allHexColors,
        oldHexs: widget.oldHexColors,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    selectedColors.clear();
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
