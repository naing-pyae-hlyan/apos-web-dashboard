import 'package:apos/lib_exp.dart';

class CustomerCommerceCard extends StatelessWidget {
  const CustomerCommerceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<CustomerModel>>(
      stream: FFirestoreUtils.customerCollection.snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const DashboardCommerceCard(
            title: "CUSTOMERS",
            count: 0,
            icon: Icons.groups_2_outlined,
            lblTodayRecord: "TODAY CUSTOMERS",
            lblMonthlyRecord: "MONTHLY CUSTOMERS",
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
        final List<CustomerModel> customers = [];
        for (var doc in snapshot.requireData.docs) {
          customers.add(doc.data());
        }

        final todayRecord = customers
            .where((CustomerModel cm) => cm.createdDate.isToday())
            .toList();

        final monthlyRecord = customers
            .where((CustomerModel cm) => cm.createdDate.isThisMonth())
            .toList();

        return DashboardCommerceCard(
          title: "CUSTOMERS",
          count: customers.length,
          icon: Icons.groups_2_outlined,
          lblTodayRecord: "TODAY CUSTOMERS",
          lblMonthlyRecord: "MONTHLY CUSTOMERS",
          todayRecord: todayRecord.length,
          monthlyRecord: monthlyRecord.length,
          isLoadingState: false,
        );
      },
    );
  }
}
