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

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      fab: FloatingActionButton(
        onPressed: () {
          showCategoryDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalHeight16,
          myTitle("Categories"),
          verticalHeight16,
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (_, state) {
                  if (state is CategoryStateLoading) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  final List<Category> categories = state.categories;
                  return DataTable(
                    border: TableBorder.all(width: 0.1),
                    dividerThickness: 0.1,
                    columns: [
                      DataColumn(label: myTitle("Id"), numeric: true),
                      DataColumn(label: myTitle("Name")),
                      DataColumn(label: myTitle("Description")),
                    ],
                    rows: categories.map(
                      (Category category) {
                        return DataRow(
                          onLongPress: () {
                            showCategoryDialog(context, category: category);
                          },
                          cells: [
                            DataCell(myText(category.id)),
                            DataCell(myText(category.name)),
                            DataCell(myText(category.description)),
                          ],
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
