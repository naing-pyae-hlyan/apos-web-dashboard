import 'package:apos/lib_exp.dart';

const dashboardCardHeight = 224.0;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      body: SizedBox(
        height: context.screenHeight,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<QuerySnapshot<OrderModel>>(
            stream: FFirestoreUtils.orderCollection
                .orderBy("order_date", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              final isLoadingState =
                  snapshot.connectionState == ConnectionState.waiting;
              final List<OrderModel> orders = [];

              if (snapshot.hasData) {
                for (var doc in snapshot.requireData.docs) {
                  orders.add(doc.data());
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      const CustomerCommerceCard(),
                      OrderCommerceCard(
                        isLoadingState: isLoadingState,
                        orders: orders,
                      ),
                      Flexible(child: SalesReportCard(orders: orders)),
                    ],
                  ),
                  verticalHeight16,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: context.screenWidth * 0.6,
                        child: DashboardTopSellingProductsCard(
                          onPressedViewOrders: () {
                            homeBloc.add(HomeEventDrawerChanged(
                              selectedPage: SelectedHome.order,
                            ));
                          },
                        ),
                      ),
                      Flexible(
                        child: DashboardRecentOrdersCard(
                          orders:
                              orders.length > 5 ? orders.sublist(0, 5) : orders,
                          onPressedViewAll: () {
                            homeBloc.add(HomeEventDrawerChanged(
                              selectedPage: SelectedHome.order,
                            ));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
