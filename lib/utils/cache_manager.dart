import 'package:apos/lib_exp.dart';

class CacheManager {
  static List<CategoryModel> categories = [];
  static List<Product> products = [];
  static List<OrderModel> orders = [];

  static UserRoleEnum userRole = UserRoleEnum.normalUser;

  static void clear() {
    categories.clear();
    products.clear();
    orders.clear();
  }
}
