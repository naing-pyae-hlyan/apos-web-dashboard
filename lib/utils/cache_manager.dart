import 'package:apos/lib_exp.dart';

class CacheManager {
  static List<Category> categories = [];
  static List<Product> products = [];
  static List<Order> orders = [];

  static List<Category> get dropdownCategories {
    if (categories.isNotEmpty && categories.first.id == "select-category") {
      return categories;
    }
    categories.insert(0, Category.forDropdown());
    return categories;
  }

  static void clear() {
    categories.clear();
    products.clear();
    orders.clear();
  }
}
