import 'package:apos/lib_exp.dart';

class DashboardRecentOrdersCard extends StatelessWidget {
  final List<Order> orders;
  final Function() onPressedViewAll;
  const DashboardRecentOrdersCard({
    super.key,
    required this.orders,
    required this.onPressedViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      cardColor: Consts.secondaryColor,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 11, 0, 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: myTitle("RECENT ORDERS")),
                TextButton(
                  onPressed: onPressedViewAll,
                  child: myText(
                    "View All",
                    fontWeight: FontWeight.bold,
                    color: Consts.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  TableTitleCell(
                    "Customers",
                    padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
                  ),
                  TableTitleCell(
                    "Price",
                    textAlign: TextAlign.end,
                    padding: EdgeInsets.fromLTRB(0, 8, 16, 8),
                  ),
                ],
              ),
              ...orders.map(
                (Order order) {
                  return TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    children: [
                      TableTextCell(
                        order.customerName,
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      ),
                      TableTextCell(
                        order.totalAmount.toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          verticalHeight16,
        ],
      ),
    );
  }
}
