import 'package:apos/lib_exp.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrderBloc orderBloc;

  void _onPressedStatus(OrderModel order) {
    if (CacheManager.isNormalUser) {
      CommonUtils.showCannotAccessDialog(context);
      return;
    }
    if (order.id == null) return;
    showOrderStatusChangeDialog(
      context,
      order: order,
      onStatusIdChanged: (int id) {
        orderBloc.add(OrderEventStatusChangedUpdateProductModel(
          order: order,
          status: id,
        ));
      },
    );
  }

  @override
  void initState() {
    orderBloc = context.read<OrderBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<OrderModel>>(
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
              hintText: "Search order id, customer name, email, phone",
              errorKey: null,
              onChanged: (String query) {
                orderBloc.add(OrderEventSearch(query));
              },
            ),
          ),
        ],
      ),
      stream: FFirestoreUtils.orderCollection
          .orderBy("order_date", descending: true)
          .snapshots(),
      streamBuilder: (QuerySnapshot<OrderModel> data) {
        final List<OrderModel> orders = [];
        for (var doc in data.docs) {
          orders.add(doc.data());
        }

        return BlocConsumer<OrderBloc, OrderState>(
          listener: (_, state) {
            if (state is OrderStateStatusChangedUpdateProductModelSuccess) {
              orderBloc.add(OrderEventStatusChange(
                order: state.order,
                status: state.status,
              ));
            }
          },
          builder: (_, state) {
            if (state is OrderStateLoading) {
              return const MyCircularIndicator();
            }

            List<OrderModel> search = [];
            if (state is OrderStateSearched) {
              search = orders.where(
                (OrderModel order) {
                  return stringCompare(order.id, state.query) ||
                      stringCompare(order.customer.name, state.query) ||
                      stringCompare(order.customer.email, state.query) ||
                      stringCompare(order.customer.phone, state.query);
                },
              ).toList();
            } else {
              search = orders;
            }

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(0.7),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
                6: FlexColumnWidth(1),
                7: FlexColumnWidth(0.5),
              },
              children: <TableRow>[
                TableRow(
                  decoration: tableTitleDecoration(),
                  children: const [
                    // TableTitleCell("S/N", textAlign: TextAlign.center),
                    TableTitleCell("Order Id"),
                    TableTitleCell("Items"),
                    TableTitleCell("Total Amount", textAlign: TextAlign.end),
                    TableTitleCell("Order Date", textAlign: TextAlign.end),
                    TableTitleCell("Pay By", textAlign: TextAlign.end),
                    TableTitleCell("Customer", textAlign: TextAlign.end),
                    TableTitleCell("Status", textAlign: TextAlign.center),
                    TableTitleCell("Details", textAlign: TextAlign.center),
                  ],
                ),
                ...List.generate(
                  search.length,
                  (index) {
                    final OrderModel order = search[index];
                    return TableRow(
                      decoration: tableTextDecoration(index),
                      children: [
                        // TableSNCell(index),
                        TableTextCell(order.readableId),
                        TableProductItemsCell(
                          items: order.items,
                        ),
                        TableTextCell(
                          order.totalAmount.toCurrencyFormat(),
                          textAlign: TextAlign.end,
                          fontWeight: FontWeight.bold,
                        ),
                        TableTextCell(
                          order.orderDate.toDDmmYYYYHHmm(),
                          textAlign: TextAlign.end,
                        ),
                        TableTextCell(
                          order.payment,
                          textAlign: TextAlign.end,
                        ),
                        TableCustomerCell(
                          id: order.customer.readableId,
                          name: order.customer.name,
                        ),
                        TableStatusCell(
                          status: order.status,
                          onPressed: () => _onPressedStatus(order),
                        ),
                        TableButtonCell(
                          icon: Icons.info_outline_rounded,
                          iconColor: Consts.primaryColor,
                          onPressed: () {
                            showOrderDetailsDialog(context, order: order);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
