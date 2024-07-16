import 'package:apos/lib_exp.dart';

const dashboardCardHeight = 192.0;

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
    return MyScaffoldDataGridView(
      blocBuilder: BlocBuilder<ProductBloc, ProductState>(
        builder: (_, state) {
          if (state is ProductStateLoading) {
            return const CircularProgressIndicator.adaptive();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  DashboardCommerceCard(
                    title: "CUSTOMERS",
                    amount: 123123.0,
                    icon: Icons.groups_2_outlined,
                    lblTodayRecord: "TODAY CUSTOMERS",
                    lblMonthlyRecord: "MONTHLY CUSTOMERS",
                    todayRecord: 12,
                    monthlyRecord: 320,
                  ),
                  DashboardCommerceCard(
                    title: "ORDERS",
                    amount: 123123.0,
                    icon: Icons.shopping_cart_outlined,
                    lblTodayRecord: "TODAY ORDERS",
                    lblMonthlyRecord: "MONTHLY ORDERS",
                    todayRecord: 12,
                    monthlyRecord: 320,
                  ),
                  Flexible(child: DailyChartCard()),
                  // CommerceCard(
                  //   title: "EARNINGS",
                  //   amount: 123123.0,
                  //   icon: Icons.bar_chart_rounded,
                  //   lblTodayRecord: "TODAY EARNINGS",
                  //   lblMonthlyRecord: "MONTHLY EARNINGS",
                  //   todayRecord: 12,
                  //   monthlyRecord: 320,
                  // ),
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
                      products: [
                        tempProduct,
                        tempProduct,
                        tempProduct,
                        tempProduct,
                        tempProduct,
                      ],
                    ),
                  ),
                  Flexible(
                    child: DashboardRecentOrdersCard(
                      orders: [
                        tempOrder,
                        tempOrder,
                        tempOrder,
                        tempOrder,
                        tempOrder,
                      ],
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
    );
  }
}
