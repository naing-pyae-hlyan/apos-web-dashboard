class ProductSize {
  final String size;
  bool status;
  ProductSize({required this.size, required this.status});

  // Just return the passed data
  static List<String> parseProductSizesToName(List<ProductSize> sizes) {
    return sizes.map((ProductSize ps) => ps.size).toList();
  }

  static List<ProductSize> parseSizesToSelectedProductSizes(
      List<String> sizes) {
    sizes.removeWhere((String s) => s == "-");
    return sizes
        .map((String size) => ProductSize(size: size, status: true))
        .toList();
  }

  static List<ProductSize> parseSiezsToAllProductSizes({
    required List<String> sizes,
    required List<String> oldSizes,
  }) {
    sizes.removeWhere((String s) => s == "-" || s.isEmpty);
    oldSizes.removeWhere((String s) => s == "-" || s.isEmpty);
    final List<ProductSize> result = [];
    for (String size in sizes) {
      bool status = false;
      for (String old in oldSizes) {
        if (old == size) {
          status = true;
          break;
        }
      }
      result.add(ProductSize(size: size, status: status));
    }
    return result;
  }
}
