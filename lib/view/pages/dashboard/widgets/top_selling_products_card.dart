import 'package:apos/lib_exp.dart';

class DashboardTopSellingProductsCard extends StatelessWidget {
  final Function() onPressedViewOrders;
  const DashboardTopSellingProductsCard({
    super.key,
    required this.onPressedViewOrders,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<ProductModel>>(
      stream: FFirestoreUtils.productCollection
          .orderBy("top_sales_count", descending: true)
          .limit(5)
          .snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot<ProductModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _DashboardTopSellingProductsCard(
            products: const [],
            onPressedViewOrders: onPressedViewOrders,
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: myText(
              snapshot.error.toString(),
              color: Consts.errorColor,
            ),
          );
        }

        QuerySnapshot<ProductModel> data = snapshot.requireData;
        final List<ProductModel> products = [];
        for (var doc in data.docs) {
          products.add(doc.data());
        }

        return _DashboardTopSellingProductsCard(
          products: products,
          onPressedViewOrders: onPressedViewOrders,
        );
      },
    );
  }
}

class _DashboardTopSellingProductsCard extends StatelessWidget {
  final Function() onPressedViewOrders;
  final List<ProductModel> products;
  const _DashboardTopSellingProductsCard({
    required this.products,
    required this.onPressedViewOrders,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: myTitle("TOP SELLING PRODUCTS", color: Colors.white),
                ),
                TextButton(
                  onPressed: onPressedViewOrders,
                  child: myText(
                    "View Orders",
                    fontWeight: FontWeight.bold,
                    // color: Consts.primaryColor,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(0.6),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(0.7),
              4: FlexColumnWidth(0.5),
              5: FlexColumnWidth(0.7),
              6: FlexColumnWidth(1.5),
            },
            children: [
              const TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  TableTitleCell(
                    "ID",
                    padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
                    textAlign: TextAlign.start,
                  ),
                  TableTitleCell(
                    "Image",
                  ),
                  TableTitleCell(
                    "Product Name",
                  ),
                  TableTitleCell(
                    "Price",
                    textAlign: TextAlign.end,
                  ),
                  TableTitleCell(
                    "Qty",
                    textAlign: TextAlign.end,
                  ),
                  TableTitleCell(
                    "Amount",
                    textAlign: TextAlign.end,
                  ),
                  TableTitleCell(
                    "Category",
                    textAlign: TextAlign.end,
                    padding: EdgeInsets.fromLTRB(0, 8, 16, 8),
                  ),
                ],
              ),
              ...products.map(
                (ProductModel product) {
                  return TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    children: [
                      TableTextCell(
                        product.readableId,
                        padding: const EdgeInsets.only(left: 16),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                      TableImagesCell(
                        images: product.base64Images.take(1).toList(),
                      ),
                      TableTextCell(
                        product.name,
                        fontWeight: FontWeight.w800,
                        maxLines: 1,
                      ),
                      TableTextCell(
                        product.price.toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                      ),
                      TableTextCell(
                        product.topSalesCount.toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                      ),
                      TableTextCell(
                        "${product.price * product.topSalesCount}"
                            .toCurrencyFormat(),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                      ),
                      TableTextCell(
                        product.categoryName,
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        padding: const EdgeInsets.only(right: 16),
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
