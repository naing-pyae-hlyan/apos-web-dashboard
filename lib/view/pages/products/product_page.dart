import 'package:apos/lib_exp.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductBloc productBloc;

  final productCollection =
      FirebaseFirestore.instance.collection("product").withConverter(
            fromFirestore: (snapshot, _) => Product.fromJson(
              snapshot.data()!,
              snapshot.id,
            ),
            toFirestore: (product, _) => product.toJson(),
          );

  @override
  void initState() {
    productBloc = context.read<ProductBloc>();
    super.initState();
  }

  void _deleteProduct(Product product) {
    if (product.id != null) {
      showConfirmDialog(
        context,
        title: "Delete Product",
        description: "Are you sure want to delete this ${product.name}?",
        onTapOk: () {
          productBloc.add(ProductEventDeleteData(productId: product.id!));
        },
      );
    }
  }

  void _updateProduct(Product product) {
    showProductBlocDialog(context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<Product>>(
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.3,
            ),
            child: MyInputField(
              controller: TextEditingController(),
              hintText: "Search",
              onChanged: (String query) {
                productBloc.add(ProductEventSearch(query: query));
              },
            ),
          ),
          horizontalWidth16,
          CategoryDropdown(
            defaultIsAll: true,
            onSelectedCategory: (Category? selectedCategory) {
              productBloc.add(
                ProductEventSearch(query: selectedCategory?.name ?? ""),
              );
            },
          ),
          const Spacer(),
          horizontalWidth16,
          MyButton(
            label: "New Product",
            icon: Icons.post_add_rounded,
            labelColor: Colors.white,
            backgroundColor: Consts.primaryColor,
            onPressed: () => showProductBlocDialog(context),
          ),
        ],
      ),
      stream: productCollection.orderBy("name").snapshots(),
      streamBuilder: (QuerySnapshot<Product> data) {
        final List<Product> products = [];
        CacheManager.products.clear();
        for (var doc in data.docs) {
          products.add(doc.data());
        }

        // Store to local cache
        CacheManager.products = products;

        return BlocBuilder<ProductBloc, ProductState>(
          builder: (_, state) {
            if (state is ProductStateLoading) {
              return const MyCircularIndicator();
            }
            List<Product> search = [];

            if (state is ProductStateSearch) {
              search = products.where((Product product) {
                return stringCompare(product.name, state.query) ||
                    stringCompare(product.readableId, state.query) ||
                    stringCompare(product.price.toString(), state.query) ||
                    stringCompare(product.categoryName, state.query);
              }).toList();
            } else {
              search = products;
            }

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1.5),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(0.5),
                6: FlexColumnWidth(1),
                7: FlexColumnWidth(1.5),
                8: FlexColumnWidth(0.5),
                9: FlexColumnWidth(0.5),
              },
              children: <TableRow>[
                TableRow(
                  decoration: tableTitleDecoration(),
                  children: const [
                    TableTitleCell(
                      "S/N",
                      textAlign: TextAlign.center,
                    ),
                    TableTitleCell("Images"),
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
                    TableTitleCell("Product Id", textAlign: TextAlign.end),
                    TableTitleCell("Category", textAlign: TextAlign.end),
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
                ..._productTableRowView(search),
              ],
            );
          },
        );
      },
    );
  }

  List<TableRow> _productTableRowView(List<Product> products) => List.generate(
        products.length,
        (index) {
          final product = products[index];
          return TableRow(
            decoration: tableTextDecoration(index),
            children: [
              TableSNCell(index),
              TableImagesCell(images: product.base64Images),
              TableTextCell(product.name, fontWeight: FontWeight.w800),
              TableTextCell(product.description),
              TableTextCell(
                product.price.toCurrencyFormat(),
                textAlign: TextAlign.end,
              ),
              TableTextCell(
                product.stockQuantity.toString(),
                textAlign: TextAlign.end,
              ),
              TableTextCell(
                product.readableId.slugify,
                textAlign: TextAlign.end,
              ),
              TableTextCell(
                product.categoryName,
                maxLines: 4,
                textAlign: TextAlign.end,
              ),
              TableButtonCell(
                icon: Icons.edit_square,
                iconColor: Colors.blueGrey,
                onPressed: () => _updateProduct(product),
              ),
              TableButtonCell(
                icon: Icons.delete,
                iconColor: Colors.red,
                onPressed: () => _deleteProduct(product),
              ),
            ],
          );
        },
      );
}
