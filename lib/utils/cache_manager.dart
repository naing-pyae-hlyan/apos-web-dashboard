import 'package:apos/lib_exp.dart';

class CacheManager {
  static List<Category> categories = [];
  static List<Product> products = [];
  static List<Order> orders = [];

  static List<Category> dropdownCategories({bool defaultIsAll = false}) {
    if (categories.isNotEmpty && categories.first.id == "select-category") {
      return categories;
    } else if (categories.isNotEmpty && categories.first.id == "all-category") {
      categories.removeAt(0);
    }
    categories.insert(0, Category.forDropdown(defaultIsAll: defaultIsAll));
    return categories;
  }

  static void clear() {
    categories.clear();
    products.clear();
    orders.clear();
  }
}
