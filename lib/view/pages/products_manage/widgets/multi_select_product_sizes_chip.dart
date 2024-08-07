import 'package:apos/lib_exp.dart';

class MultiSelectProductSizes extends StatefulWidget {
  final List<String> allSizes;
  final List<String> oldSizes;
  final Function(List<ProductSize>) onSelectedSizes;
  const MultiSelectProductSizes({
    super.key,
    required this.allSizes,
    required this.oldSizes,
    required this.onSelectedSizes,
  });

  @override
  State<MultiSelectProductSizes> createState() =>
      _MultiSelectProductSizesState();
}

class _MultiSelectProductSizesState extends State<MultiSelectProductSizes> {
  final List<ProductSize> selectedSizes = [];

  List<Widget> _buildSizeList() {
    List<Widget> choices = [];
    for (ProductSize pz in selectedSizes) {
      if (pz.size.isNotEmpty && pz.size != "-") {
        choices.add(
          ChoiceChip(
            label: myText(pz.size),
            selected: pz.status,
            onSelected: (bool selected) {
              setState(() {
                pz.status = selected;
              });

              // removed status = false sizes
              final List<ProductSize> onSelectedSizes =
                  selectedSizes.where((ProductSize pz) => pz.status).toList();
              widget.onSelectedSizes(onSelectedSizes);
            },
          ),
        );
      }
    }

    return choices;
  }

  @override
  void initState() {
    selectedSizes.clear();
    selectedSizes.addAll(ProductSize.parseSiezsToAllProductSizes(
      sizes: widget.allSizes,
      oldSizes: widget.oldSizes,
    ));
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
