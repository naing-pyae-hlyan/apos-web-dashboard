import 'package:apos/lib_exp.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrderBloc orderBloc;

  void _onPressedStatus(Order order) {
    showOrderStatusChangeDialog(
      context,
      order: order,
      onStatusIdChanged: (int id) {},
    );
  }

  @override
  void initState() {
    orderBloc = context.read<OrderBloc>();
    super.initState();

    doAfterBuild(callback: () {
      orderBloc.add(OrderEventGetOrders());
    });
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
      blocBuilder: BlocBuilder<OrderBloc, OrderState>(
        builder: (_, state) {
          if (state is OrderStateLoading) {
            return const MyCircularIndicator();
          }

          final List<Order> orders = state.orders;
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
                  TableTitleCell("Total Amount", textAlign: TextAlign.end),
                  TableTitleCell("Order Date", textAlign: TextAlign.end),
                  TableTitleCell("Customer", textAlign: TextAlign.end),
                  TableTitleCell("Status", textAlign: TextAlign.center),
                ],
              ),
              ...List.generate(
                orders.length,
                (index) {
                  return TableRow(
                    decoration: tableTextDecoration(index),
                    children: [
                      TableSNCell(index),
                      TableTextCell(orders[index].id),
                      TableProductItemsCell(
                        items: orders[index].items,
                      ),
                      TableTextCell(
                        orders[index].totalAmount.toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        fontWeight: FontWeight.bold,
                      ),
                      TableTextCell(
                        orders[index].orderDate.toDDmmYYYYHHmm(),
                        textAlign: TextAlign.end,
                      ),
                      TableCustomerCell(
                        id: orders[index].customerId,
                        name: orders[index].customerName,
                      ),
                      TableStatusCell(
                        status: orders[index].status,
                        onPressed: () => _onPressedStatus(orders[index]),
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
