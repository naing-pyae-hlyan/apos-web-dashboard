enum ProductSize {
  small("S"),
  medium("M"),
  large("L"),
  xl("XL"),
  xxl("XXL");

  final String value;
  const ProductSize(this.value);
}

ProductSize parseSizeToProductSize(String size) {
  if (size == "S") return ProductSize.small;
  if (size == "M") return ProductSize.medium;
  if (size == "L") return ProductSize.large;
  if (size == "XL") return ProductSize.xl;
  if (size == "XXL") return ProductSize.xxl;
  return ProductSize.medium;
}
