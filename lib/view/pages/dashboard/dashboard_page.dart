// import 'package:apos/lib_exp.dart';

const dashboardCardHeight = 224.0;

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   late HomeBloc homeBloc;

//   @override
//   void initState() {
//     homeBloc = context.read<HomeBloc>();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyScaffoldDataGridView(
//       elevation: 0,
//       blocBuilder: BlocBuilder<ProductBloc, ProductState>(
//         builder: (_, state) {
//           if (state is ProductStateLoading) {
//             return const MyCircularIndicator();
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Row(
//                 children: [
//                   DashboardCommerceCard(
//                     title: "CUSTOMERS",
//                     count: 1027.0,
//                     icon: Icons.groups_2_outlined,
//                     lblTodayRecord: "TODAY CUSTOMERS",
//                     lblMonthlyRecord: "MONTHLY CUSTOMERS",
//                     todayRecord: 8,
//                     monthlyRecord: 286,
//                   ),
//                   DashboardCommerceCard(
//                     title: "ORDERS",
//                     count: 208799.0,
//                     icon: Icons.shopping_cart_outlined,
//                     lblTodayRecord: "TODAY ORDERS",
//                     lblMonthlyRecord: "MONTHLY ORDERS",
//                     todayRecord: 36,
//                     monthlyRecord: 577,
//                   ),
//                   Flexible(child: SalesReportCard()),
//                 ],
//               ),
//               verticalHeight16,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: context.screenWidth * 0.6,
//                     child: DashboardTopSellingProductsCard(
//                       products: List.generate(5, (index) => tempProduct(index)),
//                     ),
//                   ),
//                   Flexible(
//                     child: DashboardRecentOrdersCard(
//                       orders: List.generate(5, (index) => tempOrder(index)),
//                       onPressedViewAll: () {
//                         homeBloc.add(HomeEventDrawerChanged(
//                           selectedPage: SelectedHome.order,
//                         ));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
