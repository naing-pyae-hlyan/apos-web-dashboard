import 'package:apos/lib_exp.dart';

class FFirestoreUtils {
  static final _database = FirebaseFirestore.instance;
  static FirebaseFirestore get database => _database;

  // Get [category] table
  static CollectionReference<CategoryModel> get categoryCollection =>
      _database.collection("category").withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) =>
                CategoryModel.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (category, _) => category.toJson(),
          );

  // Get [product] table
  static CollectionReference<ProductModel> get productCollection =>
      _database.collection("product").withConverter<ProductModel>(
            fromFirestore: (snapshot, _) =>
                ProductModel.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (product, _) => product.toJson(),
          );

  // Get [order] table
  static CollectionReference<OrderModel> get orderCollection =>
      _database.collection("order").withConverter<OrderModel>(
            fromFirestore: (snapshot, _) =>
                OrderModel.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (product, _) => product.toJson(),
          );

  // Get [customer] table
  static CollectionReference<CustomerModel> get customerCollection =>
      _database.collection("customer").withConverter<CustomerModel>(
            fromFirestore: (snapshot, _) =>
                CustomerModel.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (product, _) => product.toJson(),
          );

  // Get [user] table
  static CollectionReference<UserModel> get userCollection =>
      _database.collection("user").withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (user, _) => user.toJson(),
          );
}
