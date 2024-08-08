import 'package:apos/lib_exp.dart';

class ProductColor {
  final String name;
  final int hex;
  bool status;
  ProductColor({
    required this.name,
    required this.hex,
    required this.status,
  });

  factory ProductColor.clone(ProductColor pc) => ProductColor(
        name: pc.name,
        hex: pc.hex,
        status: pc.status,
      );

  static List<int> getAllProductColorHexs() {
    return parseProductColorsToHexs(Consts.defaultAllProductColors);
  }

  // Just return the passed data
  static List<int> parseProductColorsToHexs(List<ProductColor> colors) {
    return colors.map((ProductColor pc) => pc.hex).toList();
  }

  // Just return the passed data
  static List<ProductColor> parseHexsToProductColors(
    List<int> hexs, {
    bool defaultStatus = true,
  }) {
    final List<ProductColor> colors = [];
    for (int hex in hexs) {
      for (ProductColor color in Consts.defaultAllProductColors) {
        if (color.hex == hex) {
          colors.add(ProductColor(
            name: color.name,
            hex: hex,
            status: defaultStatus,
          ));
          break;
        }
      }
    }
    return colors;
  }

  // return type will the same as Consts.defaultAllProductColors of length
  static List<ProductColor> parseHexsToAllProductColors({
    required List<int> hexs,
    required List<int> oldHexs,
  }) {
    final List<ProductColor> result = [];
    final List<ProductColor> parsedPc = parseHexsToProductColors(
      hexs,
      defaultStatus: false,
    );

    for (ProductColor pc in parsedPc) {
      bool status = false;
      for (int old in oldHexs) {
        if (old == pc.hex) {
          status = true;
          break;
        }
      }
      result.add(ProductColor(name: pc.name, hex: pc.hex, status: status));
    }
    // colors.length will the same as Consts.defaultAllProductColors of length
    return result;
  }
}
