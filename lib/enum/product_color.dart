import 'package:flutter/material.dart';

enum ProductColor {
  red(Colors.red),
  orange(Colors.orange),
  yellow(Colors.yellow),
  green(Colors.green),
  blue(Colors.blue),
  indigo(Colors.indigo),
  violet(Colors.purple);

  final Color color;
  const ProductColor(this.color);
}
