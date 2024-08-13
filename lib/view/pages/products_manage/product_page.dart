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
      productBloc.add(
        ProductEventSearch(query: ""),
      );
    });
  }

  void _showProductDialog({
    required ProductModel? product,
    required bool isNewProduct,
  }) {
    if (CacheManager.isNormalUser) {
      CommonUtils.showCannotAccessDialog(context);
      return;
    }
    showProductBlocDialog(
      context,
      product: product,
      isNewProduct: isNewProduct,
    );
  }

  void _deleteProduct(ProductModel product) {
    if (CacheManager.isManager || CacheManager.isNormalUser) {
      CommonUtils.showCannotAccessDialog(context);
      return;
    }
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

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<ProductModel>>(
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
              errorKey: null,
              onChanged: (String query) {
                productBloc.add(ProductEventSearch(query: query));
              },
            ),
          ),
          horizontalWidth16,
          CategoryDropdown(
            categories: <CategoryModel>[
              ...CacheManager.categories,
            ]..insert(0, CategoryModel.allCategoriesValue),
            errorKey: null,
            onSelectedCategory: (CategoryModel? selectedCategory) {
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
            onPressed: () => _showProductDialog(
              product: null,
              isNewProduct: true,
            ),
          ),
        ],
      ),
      stream: FFirestoreUtils.productCollection
          .orderBy("category_name")
          .snapshots(),
      streamBuilder: (QuerySnapshot<ProductModel> data) {
        final List<ProductModel> products = [];
        CacheManager.products.clear();
        for (var doc in data.docs) {
          products.add(doc.data());
        }

        // Store to local cache
        CacheManager.products = products;

        return BlocBuilder<ProductBloc, ProductState>(
          buildWhen: (previous, current) => current is ProductStateSearch,
          builder: (_, state) {
            if (state is ProductStateLoading) {
              return const MyCircularIndicator();
            }
            List<ProductModel> search = [];

            if (state is ProductStateSearch) {
              search = products.where((ProductModel product) {
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
                5: FlexColumnWidth(1.2),
                6: FlexColumnWidth(1.2),
                7: FlexColumnWidth(1),
                8: FlexColumnWidth(1.5),
                9: FlexColumnWidth(0.5),
                10: FlexColumnWidth(0.5),
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
                    TableTitleCell("Types", textAlign: TextAlign.end),
                    TableTitleCell("Colors", textAlign: TextAlign.end),
                    TableTitleCell("Product Id", textAlign: TextAlign.end),
                    TableTitleCell("Category", textAlign: TextAlign.end),
                    TableTitleCell("Edit", textAlign: TextAlign.center),
                    TableTitleCell("Del", textAlign: TextAlign.center),
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

  List<TableRow> _productTableRowView(List<ProductModel> products) =>
      List.generate(
        products.length,
        (index) {
          final ProductModel product = products[index];
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
                product.types.isEmpty ? "-" : product.types.join(", "),
                textAlign: TextAlign.end,
                maxLines: 4,
              ),
              TableColorsCell(hexColors: product.hexColors),
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
                onPressed: () => _showProductDialog(
                  product: product,
                  isNewProduct: false,
                ),
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
