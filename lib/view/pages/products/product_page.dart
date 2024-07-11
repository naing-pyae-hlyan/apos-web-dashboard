import 'package:apos/lib_exp.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      fab: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalHeight16,
          myTitle("Products"),
          verticalHeight16,
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                border: TableBorder.all(width: 0.1),
                dividerThickness: 0.1,
                columns: [
                  DataColumn(label: myTitle("Id"), numeric: true),
                  DataColumn(label: myTitle("Name")),
                  DataColumn(label: myTitle("Description")),
                  DataColumn(label: myTitle("Price"), numeric: true),
                  DataColumn(label: myTitle("Qty"), numeric: true),
                  DataColumn(label: myTitle("Category")),
                ],
                rows: CacheManager.products.map(
                  (Product product) {
                    return DataRow(
                      onLongPress: () {
                        showCategoryDialog(
                          context,
                          category: Category(
                            id: DateTime.now().toString(),
                            name: "Apple",
                            description: "Blah",
                          ),
                        );
                      },
                      cells: [
                        DataCell(myText(product.id)),
                        DataCell(myText(product.name)),
                        DataCell(myText(product.description)),
                        DataCell(myText(product.price.toCurrencyFormat())),
                        DataCell(myText("${product.image}")),
                        // DataCell(networkImage("url")),
                        DataCell(myText(product.categoryName)),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
