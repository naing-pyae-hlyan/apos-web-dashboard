import 'package:apos/lib_exp.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          myTitle("Orders"),
          horizontalWidth8,
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
            return const CircularProgressIndicator.adaptive();
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
                  TableTitleCell("Status", textAlign: TextAlign.end),
                ],
              ),
              ...List.generate(
                20,
                (index) {
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
                      const TableStatusCell(statusId: 2),
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
