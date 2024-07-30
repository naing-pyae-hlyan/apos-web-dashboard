import 'package:apos/lib_exp.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryBloc categoryBloc;

  void _deleteCategory(Category category) {
    if (category.id != null) {
      showConfirmDialog(
        context,
        title: "Delete Category",
        description: "Are you sure want to delete this ${category.name}?",
        onTapOk: () {
          categoryBloc.add(CategoryEventDeleteData(categoryId: category.id!));
        },
      );
    }
  }

  void _updateCategory(Category category) {
    showCategoryBlocDialog(context, category: category);
  }

  @override
  void initState() {
    categoryBloc = context.read<CategoryBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<Category>>(
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.3,
            ),
            child: MyInputField(
              controller: TextEditingController(),
              hintText: "Search",
              onChanged: (String query) {
                categoryBloc.add(CategoryEventSearch(query: query));
              },
            ),
          ),
          horizontalWidth16,
          MyButton(
            label: "New Category",
            icon: Icons.post_add_rounded,
            onPressed: () => showCategoryBlocDialog(context),
          ),
        ],
      ),
      // Get data from firebase
      stream: FFirestoreUtils.categoryCollection.orderBy("name").snapshots(),
      streamBuilder: (QuerySnapshot<Category> data) {
        final List<Category> categories = [];
        CacheManager.categories.clear();

        for (var doc in data.docs) {
          categories.add(doc.data());
        }
        // Store to local cache
        CacheManager.categories = categories;

        return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (_, state) {
            if (state is CategoryStateLoading) {
              return const MyCircularIndicator();
            }

            List<Category> search = [];
            if (state is CategoryStateSearch) {
              search = categories.where((Category category) {
                return stringCompare(category.name, state.query) ||
                    stringCompare(category.readableId, state.query);
              }).toList();
            } else {
              search = categories;
            }

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(1),
                3: FlexColumnWidth(0.7),
                4: FlexColumnWidth(0.5),
                5: FlexColumnWidth(0.5),
                6: FlexColumnWidth(0.5),
              },
              children: <TableRow>[
                TableRow(
                  decoration: tableTitleDecoration(),
                  children: const [
                    TableTitleCell("S/N", textAlign: TextAlign.center),
                    TableTitleCell("Name"),
                    TableTitleCell("Sizes", textAlign: TextAlign.end),
                    TableTitleCell("Colors", textAlign: TextAlign.end),
                    TableTitleCell("Category Id", textAlign: TextAlign.end),
                    TableTitleCell("Edit", textAlign: TextAlign.center),
                    TableTitleCell("Delete", textAlign: TextAlign.center),
                  ],
                ),
                ..._categoryTableRowView(search),
              ],
            );
          },
        );
      },
    );
  }

  List<TableRow> _categoryTableRowView(List<Category> categories) =>
      List.generate(
        categories.length,
        (index) {
          final Category category = categories[index];
          return TableRow(
            decoration: tableTextDecoration(index),
            children: [
              TableSNCell(index),
              TableTextCell(category.name, fontWeight: FontWeight.w800),
              TableTextCell(
                category.hasSize ? "S, M, L, XL, XXL" : "no size",
                textAlign: TextAlign.end,
              ),
              TableTextCell("${category.hasColor}", textAlign: TextAlign.end),
              TableTextCell(
                categories[index].readableId.slugify,
                textAlign: TextAlign.end,
              ),
              TableButtonCell(
                icon: Icons.edit_square,
                iconColor: Colors.blueGrey,
                onPressed: () => _updateCategory(category),
              ),
              TableButtonCell(
                icon: Icons.delete,
                iconColor: Colors.red,
                onPressed: () => _deleteCategory(category),
              ),
            ],
          );
        },
      );
}
