import 'package:apos/lib_exp.dart';

class OrderCommerceCard extends StatelessWidget {
  final List<OrderModel> orders;
  final bool isLoadingState;
  const OrderCommerceCard({
    super.key,
    required this.orders,
    required this.isLoadingState,
  });

  @override
  Widget build(BuildContext context) {
    final todayRecord =
        orders.where((OrderModel cm) => cm.orderDate.isToday()).toList();

    final monthlyRecord =
        orders.where((OrderModel cm) => cm.orderDate.isThisMonth()).toList();
    return DashboardCommerceCard(
      title: "ORDERS",
      count: orders.length,
      icon: Icons.shopping_cart_outlined,
      lblTodayRecord: "TODAY ORDERS",
      lblMonthlyRecord: "MONTHLY ORDERS",
      todayRecord: todayRecord.length,
      monthlyRecord: monthlyRecord.length,
      isLoadingState: isLoadingState,
    );
  }
}
