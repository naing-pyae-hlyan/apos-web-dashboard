import 'dart:math';

import 'package:apos/lib_exp.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          myTitle("Customers"),
          horizontalWidth8,
          Container(
            constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.3,
            ),
            child: MyInputField(
              controller: TextEditingController(),
              hintText: "Search by name, phone, email, id",
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
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(2),
              5: FlexColumnWidth(1),
              // 6: FlexColumnWidth(0.5),
              // 7: FlexColumnWidth(0.5),
            },
            children: <TableRow>[
              TableRow(
                decoration: tableTitleDecoration(),
                children: const [
                  TableTitleCell("S/N", textAlign: TextAlign.center),
                  TableTitleCell("Name"),
                  TableTitleCell("Phone"),
                  TableTitleCell("Email"),
                  TableTitleCell("Address"),
                  TableTitleCell(
                    "Customer ID",
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              ...List.generate(
                20,
                (index) {
                  return TableRow(
                    decoration: tableTextDecoration(index),
                    children: [
                      TableSNCell(index),
                      const TableTextCell("Username"),
                      const TableTextCell("09123456789"),
                      const TableTextCell("user@example.com"),
                      const TableTextCell("Yangon"),
                      TableTextCell(
                        "${Random().nextInt(9999)}",
                        textAlign: TextAlign.end,
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
