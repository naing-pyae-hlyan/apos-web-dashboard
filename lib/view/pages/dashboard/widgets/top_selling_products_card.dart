import 'package:apos/lib_exp.dart';

class DashboardTopSellingProductsCard extends StatelessWidget {
  final List<Product> products;
  const DashboardTopSellingProductsCard({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      // cardColor: Consts.primaryColor,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Consts.primaryColor,
            ),
            padding: const EdgeInsets.all(16),
            child: myTitle("TOP SELLING PRODUCTS", color: Colors.white),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(0.7),
              2: FlexColumnWidth(0.7),
              3: FlexColumnWidth(0.7),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  TableTitleCell(
                    "Name",
                    padding: EdgeInsets.only(left: 16),
                  ),
                  TableTitleCell("Price", textAlign: TextAlign.end),
                  TableTitleCell(
                    "Quantity",
                    textAlign: TextAlign.end,
                  ),
                  TableTitleCell(
                    "Amount",
                    textAlign: TextAlign.end,
                    padding: EdgeInsets.only(right: 16),
                  ),
                ],
              ),
              ...products.map(
                (Product product) {
                  return TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    children: [
                      TableTextCell(
                        product.name,
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      ),
                      TableTextCell(
                        product.price.toCurrencyFormat(),
                        textAlign: TextAlign.end,
                      ),
                      TableTextCell(
                        "${product.stockQuantity}",
                        textAlign: TextAlign.end,
                      ),
                      TableTextCell(
                        product.price.toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
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
}
