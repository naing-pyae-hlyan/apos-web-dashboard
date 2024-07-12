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
    return MyScaffold(
      padding: const EdgeInsets.all(32.0),
      body: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyHeader(
                title: "Categories",
                addBtnTitle: "New Category",
                onTapAdd: () => showCategoryDialog(context),
              ),
              verticalHeight32,
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
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
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Consts.primaryColor,
                                width: 0.3,
                              ),
                            ),
                            children: const [
                              TableTitleCell("S/N",
                                  textAlign: TextAlign.center),
                              TableTitleCell("Name"),
                              TableTitleCell("Description"),
                              TableTitleCell("Edit",
                                  textAlign: TextAlign.center),
                              TableTitleCell("Delete",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                          ...List.generate(
                            categories.length,
                            (index) {
                              return TableRow(
                                decoration: BoxDecoration(
                                  color: index.isOdd
                                      ? Consts.primaryColor.withOpacity(0.1)
                                      : Colors.white,
                                ),
                                children: [
                                  TableTextCell(
                                    "${index + 1}",
                                    textAlign: TextAlign.center,
                                  ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
