import 'package:apos/lib_exp.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late CustomerBloc customerBloc;

  void _onUpdateStatus(CustomerModel customer) {
    if (CacheManager.isManager || CacheManager.isNormalUser) {
      CommonUtils.showCannotAccessDialog(context);
      return;
    }

    if (customer.id == null) return;
    String title = customer.status == 1 ? "Disable" : "Activate";

    showConfirmDialog(
      context,
      title: title,
      description: "Are you sure want to ${title.toLowerCase()} this account?",
      onTapOk: () {
        customerBloc.add(CustomerEventUpdateStatus(
          customerId: customer.id!,
          status: customer.status == 1 ? 0 : 1,
        ));
      },
    );
  }

  @override
  void initState() {
    customerBloc = context.read<CustomerBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<CustomerModel>>(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.3,
            ),
            child: MyInputField(
              controller: TextEditingController(),
              hintText: "Search by name, phone, email, id",
              errorKey: null,
              onChanged: (String query) {
                customerBloc.add(CustomerEventSearch(query));
              },
            ),
          ),
        ],
      ),
      stream: FFirestoreUtils.customerCollection.orderBy("name").snapshots(),
      streamBuilder: (QuerySnapshot<CustomerModel> data) {
        final List<CustomerModel> customers = [];

        for (var doc in data.docs) {
          customers.add(doc.data());
        }

        return BlocBuilder<CustomerBloc, CustomerState>(
          builder: (_, state) {
            if (state is CustomerStateLoading) {
              return const MyCircularIndicator();
            }

            List<CustomerModel> search = [];

            if (state is CustomerStateSearch) {
              search = customers.where(
                (CustomerModel cm) {
                  return stringCompare(cm.name, state.query) ||
                      stringCompare(cm.email, state.query) ||
                      stringCompare(cm.phone, state.query);
                },
              ).toList();
            } else {
              search = customers;
            }

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(2),
                5: FlexColumnWidth(1),
                6: FlexColumnWidth(0.5),
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
                    TableTitleCell("Status"),
                  ],
                ),
                ...List.generate(
                  search.length,
                  (index) {
                    final CustomerModel customer = search[index];
                    return TableRow(
                      decoration: tableTextDecoration(index),
                      children: [
                        TableSNCell(index),
                        TableTextCell(customer.name),
                        TableTextCell(customer.phone),
                        TableTextCell(customer.email),
                        TableTextCell(customer.address),
                        TableTextCell(
                          customer.readableId,
                          textAlign: TextAlign.end,
                        ),
                        TableButtonCell(
                          icon: customer.status == 1
                              ? Icons.check_box
                              : Icons.disabled_by_default,
                          iconColor: customer.status == 1
                              ? Consts.currencyGreen
                              : Consts.currencyRed,
                          onPressed: () => _onUpdateStatus(customer),
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
