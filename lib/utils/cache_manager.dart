import 'package:apos/lib_exp.dart';

class CacheManager {
  static List<CategoryModel> categories = [];
  static List<ProductModel> products = [];
  static List<OrderModel> orders = [];

  static UserModel? currentUser;

  static bool get isSuperAdmin {
    return currentUser?.userRole == UserRoleEnum.superAdmin;
  }

  static bool get isManager {
    return currentUser?.userRole == UserRoleEnum.manager;
  }

  static bool get isNormalUser {
    return currentUser?.userRole == UserRoleEnum.normalUser;
  }

  static void clear() {
    categories.clear();
    products.clear();
    orders.clear();
  }
}
