enum ProductColors {
  black(name: "Black", hex: 0xFF000000),
  white(name: "White", hex: 0xFFFFFFFF),
  red(name: "Red", hex: 0xFFFF0000),
  blue(name: "Blue", hex: 0xFF0000FF),
  green(name: "Green", hex: 0xFF008000),
  yellow(name: "Yellow", hex: 0xFFFFFF00),
  grey(name: "Grey", hex: 0xFF808080);

  final String name;
  final int hex;
  const ProductColors({
    required this.name,
    required this.hex,
  });
}

List<ProductColors> parseHexsToProductColors(List<int> hex) {
  List<ProductColors> result = [];
  for (var value in ProductColors.values) {
    for (var h in hex) {
      if (h == value.hex) {
        result.add(value);
        break;
      }
    }
  }
  return result;
}

List<int> parseProductColorsToHexs(List<ProductColors> pcs) {
  List<int> result = [];
  for (var value in pcs) {
    result.add(value.hex);
  }
  return result;
}

String parseHexToProductColorName(int hex) {
  String result = "";
  for (var value in ProductColors.values) {
    if (value.hex == hex) {
      result = value.name;
      break;
    }
  }
  return result;
}

int parseProductColorNameToHex(String name) {
  return ProductColors.values
      .firstWhere((ProductColors pc) => pc.name == name)
      .hex;
}
