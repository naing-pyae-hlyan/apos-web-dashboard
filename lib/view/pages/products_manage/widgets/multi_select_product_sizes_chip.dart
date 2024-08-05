import 'package:apos/lib_exp.dart';

class MultiSelectProductSizes extends StatefulWidget {
  final List<String> sizes;
  final List<String> oldSizes;
  final Function(List<String>) onSelectedSizes;
  const MultiSelectProductSizes({
    super.key,
    required this.sizes,
    required this.oldSizes,
    required this.onSelectedSizes,
  });

  @override
  State<MultiSelectProductSizes> createState() =>
      _MultiSelectProductSizesState();
}

class _MultiSelectProductSizesState extends State<MultiSelectProductSizes> {
  final List<String> selectedSizes = [];

  List<Widget> _buildSizeList() {
    List<Widget> choices = [];
    for (final String size in widget.sizes) {
      choices.add(
        ChoiceChip(
          label: myText(size),
          selected: selectedSizes.contains(size),
          onSelected: (bool selected) {
            setState(() {
              selectedSizes.contains(size)
                  ? selectedSizes.remove(size)
                  : selectedSizes.add(size);
            });
            widget.onSelectedSizes(selectedSizes);
          },
        ),
      );
    }

    return choices;
  }

  @override
  void initState() {
    selectedSizes.clear();
    selectedSizes.addAll(widget.oldSizes);
    super.initState();
  }

  @override
  void dispose() {
    selectedSizes.clear();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MultiSelectProductSizes oldWidget) {
    // selectedSizes.clear();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_buildSizeList().isEmpty) return emptyUI;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        verticalHeight16,
        myText("Avaliable Sizes", fontWeight: FontWeight.w800),
        verticalHeight8,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _buildSizeList(),
        ),
      ],
    );
  }
}
