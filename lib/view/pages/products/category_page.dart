import 'package:apos/lib_exp.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categoryCollection =
      FirebaseFirestore.instance.collection("category").withConverter<Category>(
            fromFirestore: (snapshot, _) => Category.fromJson(
              snapshot.data()!,
              snapshot.id,
            ),
            toFirestore: (category, _) => category.toJson(),
          );

  void _deleteCategory(Category category) {
    if (category.id != null) {
      showConfirmDialog(
        context,
        title: "Delete Category",
        description: "Are you sure want to delete this ${category.name}?",
        onTapOk: () {},
      );
    }
  }

  void _updateCategory(Category category) {
    showCategoryBlocDialog(context, category: category);
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
            onPressed: () => showCategoryBlocDialog(context),
          ),
        ],
      ),
      blocBuilder: StreamBuilder(
        stream: categoryCollection.orderBy("name").snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyCircularIndicator();
          }

          if (snapshot.hasError) {
            return Center(
              child: myText(
                snapshot.error.toString(),
                color: Consts.errorColor,
              ),
            );
          }

          final List<Category> categories = [];
          final data = snapshot.requireData;

          for (var doc in data.docs) {
            categories.add(doc.data());
          }

          CacheManager.categories = categories;

          return Table(
            columnWidths: const {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(0.5),
              5: FlexColumnWidth(0.5),
            },
            children: <TableRow>[
              TableRow(
                decoration: tableTitleDecoration(),
                children: const [
                  TableTitleCell("S/N", textAlign: TextAlign.center),
                  TableTitleCell("Name"),
                  TableTitleCell("Description"),
                  TableTitleCell("Category Id", textAlign: TextAlign.end),
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
                      TableTextCell(
                        categories[index].id,
                        textAlign: TextAlign.end,
                      ),
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
