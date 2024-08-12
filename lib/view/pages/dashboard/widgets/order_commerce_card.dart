import 'package:apos/lib_exp.dart';

class OrderCommerceCard extends StatelessWidget {
  const OrderCommerceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<OrderModel>>(
      stream: FFirestoreUtils.orderCollection.snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const DashboardCommerceCard(
            title: "ORDERS",
            count: 0,
            icon: Icons.shopping_cart_outlined,
            lblTodayRecord: "TODAY ORDERS",
            lblMonthlyRecord: "MONTHLY ORDERS",
            todayRecord: 0,
            monthlyRecord: 0,
            isLoadingState: true,
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: errorText(snapshot.error.toString()),
          );
        }
        final List<OrderModel> orders = [];
        for (var doc in snapshot.requireData.docs) {
          orders.add(doc.data());
        }

        final todayRecord =
            orders.where((OrderModel cm) => cm.orderDate.isToday()).toList();

        final monthlyRecord = orders
            .where((OrderModel cm) => cm.orderDate.isThisMonth())
            .toList();

        return DashboardCommerceCard(
          title: "ORDERS",
          count: orders.length,
          icon: Icons.shopping_cart_outlined,
          lblTodayRecord: "TODAY ORDERS",
          lblMonthlyRecord: "MONTHLY ORDERS",
          todayRecord: todayRecord.length,
          monthlyRecord: monthlyRecord.length,
          isLoadingState: false,
        );
      },
    );
  }
}
