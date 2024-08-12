import 'package:apos/lib_exp.dart';

class DashboardRecentOrdersCard extends StatelessWidget {
  final List<OrderModel> orders;
  final Function() onPressedViewAll;
  const DashboardRecentOrdersCard({
    super.key,
    required this.orders,
    required this.onPressedViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Consts.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: myTitle("RECENT ORDERS", color: Colors.white)),
                TextButton(
                  onPressed: onPressedViewAll,
                  child: myText(
                    "View All",
                    fontWeight: FontWeight.bold,
                    // color: Consts.primaryColor,
                    color: Colors.white,
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
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  TableTitleCell(
                    "Customers",
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  TableTitleCell(
                    "Total Amount",
                    textAlign: TextAlign.end,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  TableTitleCell(
                    "Order Id",
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textAlign: TextAlign.end,
                  ),
                  TableTitleCell(
                    "Status",
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              ...orders.map(
                (OrderModel order) {
                  return TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    children: [
                      TableTextCell(
                        order.customer.name,
                        padding: textCellPadding,
                        maxLines: 1,
                      ),
                      TableTextCell(
                        order.totalAmount.toCurrencyFormat(),
                        padding: textCellPadding,
                        maxLines: 1,
                        textAlign: TextAlign.end,
                      ),
                      TableTextCell(
                        order.readableId,
                        padding: textCellPadding,
                        textAlign: TextAlign.end,
                      ),
                      TableTextCell(
                        order.status.name,
                        labelColor: order.status.color,
                        padding: textCellPadding,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          verticalHeight8,
        ],
      ),
    );
  }

  EdgeInsetsGeometry get textCellPadding => const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      );
}
