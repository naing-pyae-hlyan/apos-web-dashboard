import 'package:apos/lib_exp.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductBloc productBloc;

  @override
  void initState() {
    productBloc = context.read<ProductBloc>();
    super.initState();

    doAfterBuild(callback: () {
      productBloc.add(ProductEventReadData());
    });
  }

  void _deleteProduct(Product product) {
    showConfirmDialog(
      context,
      title: "Delete Product",
      description: "Are you sure want to delete this ${product.name}?",
      onTapOk: () {
        productBloc.add(
          ProductEventDeleteData(productId: product.id),
        );
      },
    );
  }

  void _updateProduct(Product product) {
    showProductDialog(context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView(
      header: MyHeader(
        title: "Products",
        actions: [
          MyButton(
            label: "New Product",
            onPressed: () => showProductDialog(context),
          ),
          horizontalWidth16,
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

          final List<Product> products = state.products;

          return Table(
            columnWidths: const {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(0.5),
              6: FlexColumnWidth(0.5),
              7: FlexColumnWidth(0.5),
            },
            children: <TableRow>[
              TableRow(
                decoration: tableTitleDecoration(),
                children: const [
                  TableTitleCell(
                    "S/N",
                    textAlign: TextAlign.center,
                  ),
                  TableTitleCell("Image"),
                  TableTitleCell("Name"),
                  TableTitleCell("Description"),
                  TableTitleCell(
                    "Price",
                    textAlign: TextAlign.end,
                  ),
                  TableTitleCell(
                    "Qty",
                    textAlign: TextAlign.end,
                  ),
                  TableTitleCell(
                    "Edit",
                    textAlign: TextAlign.center,
                  ),
                  TableTitleCell(
                    "Delete",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              ...List.generate(
                products.length,
                (index) {
                  return TableRow(
                    decoration: tableTextDecoration(index),
                    children: [
                      TableSNCell(index),
                      // const TableCell(
                      //   child: Icon(Icons.abc, size: 128),
                      // ),
                      const TableTextCell(""),
                      TableTextCell(products[index].name),
                      TableTextCell(products[index].description),
                      TableTextCell(
                        products[index].price.toCurrencyFormat(),
                        textAlign: TextAlign.end,
                      ),
                      TableTextCell(
                        products[index].stockQuantity.toString(),
                        textAlign: TextAlign.end,
                      ),
                      TableButtonCell(
                        icon: Icons.edit_square,
                        iconColor: Colors.blueGrey,
                        onPressed: () {
                          _updateProduct(products[index]);
                        },
                      ),
                      TableButtonCell(
                        icon: Icons.delete,
                        iconColor: Colors.red,
                        onPressed: () {
                          _deleteProduct(products[index]);
                        },
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
