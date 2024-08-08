import 'package:apos/lib_exp.dart';

class CacheManager {
  static List<CategoryModel> categories = [];
  static List<ProductModel> products = [];
  static List<OrderModel> orders = [];

  static UserModel? _currentUser;
  static UserModel? get currentUesr => _currentUser;
  static set currentUser(UserModel um) => _currentUser = um;

  static bool get isSuperAdmin {
    return _currentUser?.userRole == UserRoleEnum.superAdmin;
  }

  static bool get isManager {
    return _currentUser?.userRole == UserRoleEnum.manager;
  }

  static bool get isNormalUser {
    return _currentUser?.userRole == UserRoleEnum.normalUser;
  }

  static void clear() {
    categories.clear();
    products.clear();
    orders.clear();
  }
}
