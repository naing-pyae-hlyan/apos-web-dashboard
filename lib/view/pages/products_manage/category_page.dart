import 'package:apos/lib_exp.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryBloc categoryBloc;

  void _showCategoryDialog({
    required CategoryModel? category,
    required bool isNewCategory,
  }) {
    if (CacheManager.isNormalUser) {
      CommonUtils.showCannotAccessDialog(context);
      return;
    }
    showCategoryBlocDialog(
      context,
      category: category,
      isNewCategory: isNewCategory,
    );
  }

  void _deleteCategory(CategoryModel category) {
    if (CacheManager.isManager || CacheManager.isNormalUser) {
      CommonUtils.showCannotAccessDialog(context);
      return;
    }

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

  @override
  void initState() {
    categoryBloc = context.read<CategoryBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<CategoryModel>>(
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
              errorKey: null,
              onChanged: (String query) {
                categoryBloc.add(CategoryEventSearch(query: query));
              },
            ),
          ),
          horizontalWidth16,
          MyButton(
            label: "New Category",
            icon: Icons.post_add_rounded,
            onPressed: () => _showCategoryDialog(
              category: null,
              isNewCategory: true,
            ),
          ),
        ],
      ),
      // Get data from firebase
      stream: FFirestoreUtils.categoryCollection.orderBy("name").snapshots(),
      streamBuilder: (QuerySnapshot<CategoryModel> data) {
        final List<CategoryModel> categories = [];
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

            List<CategoryModel> search = [];
            if (state is CategoryStateSearch) {
              search = categories.where((CategoryModel category) {
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
                3: FlexColumnWidth(1),
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
                    TableTitleCell("Types", textAlign: TextAlign.end),
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

  List<TableRow> _categoryTableRowView(List<CategoryModel> categories) =>
      List.generate(
        categories.length,
        (index) {
          final CategoryModel category = categories[index];
          return TableRow(
            decoration: tableTextDecoration(index),
            children: [
              TableSNCell(index),
              TableTextCell(category.name, fontWeight: FontWeight.w800),
              TableTextCell(
                category.sizes.isEmpty ? "-" : category.sizes.join(", "),
                textAlign: TextAlign.end,
              ),
              TableColorsCell(hexColors: category.colorHexs),
              TableTextCell(
                categories[index].readableId.slugify,
                textAlign: TextAlign.end,
              ),
              TableButtonCell(
                icon: Icons.edit_square,
                iconColor: Colors.blueGrey,
                onPressed: () => _showCategoryDialog(
                  category: category,
                  isNewCategory: false,
                ),
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
