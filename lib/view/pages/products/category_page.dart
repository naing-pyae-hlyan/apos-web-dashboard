import 'package:apos/lib_exp.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    categoryBloc = context.read<CategoryBloc>();
    super.initState();

    doAfterBuild(callback: () {
      categoryBloc.add(CategoryEventReadData());
    });
  }

  void _deleteCategory(Category category) {
    showConfirmDialog(
      context,
      title: "Delete Category",
      description: "Are you sure want to delete this ${category.name}?",
      onTapOk: () {
        categoryBloc.add(
          CategoryEventDeleteData(categoryId: category.id),
        );
      },
    );
  }

  void _updateCategory(Category category) {
    showCategoryDialog(context, category: category);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView(
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
            ),
          ),
          horizontalWidth16,
          MyButton(
            label: "New Category",
            onPressed: () => showCategoryDialog(context),
          ),
        ],
      ),
      blocBuilder: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (_, state) {
          if (state is CategoryStateLoading) {
            return const CircularProgressIndicator.adaptive();
          }

          final List<Category> categories = state.categories;

          return Table(
            columnWidths: const {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(0.5),
              4: FlexColumnWidth(0.5),
            },
            children: <TableRow>[
              TableRow(
                decoration: tableTitleDecoration(),
                children: const [
                  TableTitleCell("S/N", textAlign: TextAlign.center),
                  TableTitleCell("Name"),
                  TableTitleCell("Description"),
                  TableTitleCell("Edit", textAlign: TextAlign.center),
                  TableTitleCell("Delete", textAlign: TextAlign.center),
                ],
              ),
              ...List.generate(
                categories.length,
                (index) {
                  return TableRow(
                    decoration: tableTextDecoration(index),
                    children: [
                      TableSNCell(index),
                      TableTextCell(categories[index].name),
                      TableTextCell(categories[index].description),
                      TableButtonCell(
                        icon: Icons.edit_square,
                        iconColor: Colors.blueGrey,
                        onPressed: () => _updateCategory(
                          categories[index],
                        ),
                      ),
                      TableButtonCell(
                        icon: Icons.delete,
                        iconColor: Colors.red,
                        onPressed: () => _deleteCategory(
                          categories[index],
                        ),
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
