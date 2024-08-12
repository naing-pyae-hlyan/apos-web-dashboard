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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(
                children: [
                  CustomerCommerceCard(),
                  OrderCommerceCard(),
                  Flexible(child: SalesReportCard()),
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
          ),
        ),
      ),
    );
  }
}
