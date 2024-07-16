import 'dart:math';

import 'package:apos/lib_exp.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  void _onPressedStatus(Order order) {
    if (parseToOrderStatus(order.statusId) == OrderStatus.delivered) return;

    showOrderStatusChangeDialog(
      context,
      order: order,
      onStatusIdChanged: (int id) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TODO add status filter
          Container(
            constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.3,
            ),
            child: MyInputField(
              controller: TextEditingController(),
              hintText: "Search",
            ),
          ),
        ],
      ),
      blocBuilder: BlocBuilder<ProductBloc, ProductState>(
        builder: (_, state) {
          if (state is ProductStateLoading) {
            return const MyCircularIndicator();
          }

          return Table(
            columnWidths: const {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(0.7),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1),
              6: FlexColumnWidth(1),
            },
            children: <TableRow>[
              TableRow(
                decoration: tableTitleDecoration(),
                children: const [
                  TableTitleCell("S/N", textAlign: TextAlign.center),
                  TableTitleCell("Order Id"),
                  TableTitleCell("Items"),
                  // TableTitleItemsCell(),
                  TableTitleCell("Total Amount", textAlign: TextAlign.end),
                  TableTitleCell("Order Date", textAlign: TextAlign.end),
                  TableTitleCell("Customer", textAlign: TextAlign.end),
                  TableTitleCell("Status", textAlign: TextAlign.center),
                ],
              ),
              ...List.generate(
                20,
                (index) {
                  final int statusId = Random().nextInt(4);
                  return TableRow(
                    decoration: tableTextDecoration(index),
                    children: [
                      TableSNCell(index),
                      const TableTextCell("12312331"),
                      TableProductItemsCell(
                        items: [
                          tempItem,
                          tempItem,
                          tempItem,
                          tempItem,
                          tempItem,
                        ],
                      ),
                      TableTextCell(
                        "1000".toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        fontWeight: FontWeight.bold,
                      ),
                      TableTextCell(
                        DateTime.now().toString(),
                        textAlign: TextAlign.end,
                      ),
                      const TableCustomerCell(
                        id: "12312312321",
                        name: "Mg Mg",
                      ),
                      TableStatusCell(
                        statusId: statusId,
                        onPressed: () => _onPressedStatus(Order(
                          id: "123",
                          customerId: "456",
                          customerName: "Customer A",
                          items: [],
                          orderDate: DateTime.now(),
                          totalAmount: 9999,
                          statusId: statusId,
                        )),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
