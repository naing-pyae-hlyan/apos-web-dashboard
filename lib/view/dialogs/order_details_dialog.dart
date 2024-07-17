import 'package:apos/lib_exp.dart';

void showOrderDetailsDialog(
  BuildContext context, {
  required Order order,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => OrderDetailsDialog(order: order),
    );

class OrderDetailsDialog extends StatefulWidget {
  final Order order;
  const OrderDetailsDialog({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailsDialog> createState() => _OrderDetailsDialogState();
}

class _OrderDetailsDialogState extends State<OrderDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Consts.secondaryColor,
      title: Column(
        children: [
          myTitle("Order Details (ID:${widget.order.id})"),
          const SizedBox(
            width: 164,
            child: Divider(color: Consts.primaryFontColor),
          ),
        ],
      ),
      actions: [],
      content: SizedBox(
        width: context.screenWidth * 0.5,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                  1: FlexColumnWidth(0.8),
                },
                children: <TableRow>[
                  orderDetailsTableRow(
                    label: "Order Status:",
                    value: "(${widget.order.status.name})",
                    valueFontWeight: FontWeight.bold,
                  ),
                  orderDetailsTableRow(
                    label: "Order Date:",
                    value: widget.order.orderDate.toDDmmYYYYHHmm(),
                  ),
                  orderDetailsTableRow(
                    label: "Customer Name:",
                    value: widget.order.customer.name,
                  ),
                  orderDetailsTableRow(
                    label: "Customer Phone:",
                    value: widget.order.customer.phone,
                  ),
                  orderDetailsTableRow(
                    label: "Address:",
                    value: widget.order.customer.address,
                  ),
                ],
              ),
              verticalHeight24,
              const MySeparator(),
              verticalHeight8,
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(0.5),
                  1: FlexColumnWidth(0.5),
                },
                children: <TableRow>[
                  const TableRow(
                    children: [
                      TableTitleCell(
                        "Item Name",
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      TableTitleCell(
                        "Qty",
                        textAlign: TextAlign.end,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      TableTitleCell(
                        "Amount",
                        textAlign: TextAlign.end,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                    ],
                  ),
                  ...widget.order.items.map(
                    (Item item) {
                      return TableRow(
                        children: [
                          TableTextCell(
                            item.name,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          TableTextCell(
                            "${item.quantity}",
                            textAlign: TextAlign.end,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          TableTextCell(
                            item.amount.toCurrencyFormat(),
                            textAlign: TextAlign.end,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              verticalHeight8,
              const MySeparator(),
              verticalHeight8,
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: myTitle(
                    "Total : ${widget.order.totalAmount.toCurrencyFormat()}",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              verticalHeight8,
              const MySeparator(),
              verticalHeight16,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Consts.primaryFontColor,
                  ),
                  horizontalWidth8,
                  Flexible(
                    child: myText(
                      widget.order.comment,
                      maxLines: 4,
                      fontWeight: FontWeight.bold,
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

  TableRow orderDetailsTableRow({
    required String label,
    required String value,
    FontWeight valueFontWeight = FontWeight.normal,
  }) =>
      TableRow(
        children: [
          const TableCell(child: emptyUI),
          TableTextCell(
            label,
            textAlign: TextAlign.start,
            padding: EdgeInsets.zero,
            verticalAlignment: TableCellVerticalAlignment.top,
          ),
          TableTextCell(
            value,
            textAlign: TextAlign.end,
            fontWeight: valueFontWeight,
            padding: const EdgeInsets.only(right: 8),
            verticalAlignment: TableCellVerticalAlignment.top,
            maxLines: 4,
          ),
        ],
      );
}
