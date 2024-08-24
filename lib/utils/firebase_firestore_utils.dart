import 'package:apos/lib_exp.dart';
import 'package:elegant_notification/elegant_notification.dart';

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

  static void listenNewOrder(BuildContext context) {
    orderCollection.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          if (change.type == DocumentChangeType.added) {
            final data = change.doc.data();
            String? message;
            if (data?.statusId == 0) {
              message = "You got a new order.";
            }
            if (message != null) {
              ElegantNotification(
                title: myTitle("Notification", color: Colors.white),
                description:
                    myText("You got a new order.", color: Colors.white),
                showProgressIndicator: false,
                width: context.screenWidth * 0.3,
                background: Consts.primaryColor,
                icon: const Icon(
                  Icons.notifications_active_sharp,
                  color: Colors.white,
                  size: 48,
                ),
              ).show(context);

              break;
            }
          }
        }
      },
    );
  }
}
