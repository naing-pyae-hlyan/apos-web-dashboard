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
      cardColor: Consts.secondaryColor,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: myTitle("TOP SELLING PRODUCTS"),
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
                      const TableTextCell("3", textAlign: TextAlign.end),
                      TableTextCell(
                        "1234".toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          verticalHeight16,
        ],
      ),
    );
  }
}
