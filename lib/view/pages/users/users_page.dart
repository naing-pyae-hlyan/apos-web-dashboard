import 'package:apos/lib_exp.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late UsersBloc usersBloc;

  void _deleteUser(UserModel user) {
    if (user.id != null) {
      showConfirmDialog(
        context,
        title: "Delete User",
        description: "Are you sure want to delete this ${user.username}?",
        onTapOk: () {
          usersBloc.add(UsersEventDelete(userId: user.id!));
        },
      );
    }
  }

  @override
  void initState() {
    usersBloc = context.read<UsersBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<UserModel>>(
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
                usersBloc.add(UsersEventSearch(query: query));
              },
            ),
          ),
          horizontalWidth16,
          MyButton(
            label: "New User",
            icon: Icons.post_add_rounded,
            onPressed: () => showUserDialog(context),
          ),
        ],
      ),
      stream: FFirestoreUtils.userCollection.snapshots(),
      streamBuilder: (QuerySnapshot<UserModel> data) {
        final List<UserModel> users = [];

        for (var doc in data.docs) {
          users.add(doc.data());
        }

        return BlocBuilder<UsersBloc, UsersState>(
          builder: (_, state) {
            if (state is UsersStateLoading) {
              return const MyCircularIndicator();
            }
            List<UserModel> search = [];
            if (state is UsersStateSearch) {
              search = users.where((UserModel user) {
                return stringCompare(user.username, state.query) ||
                    stringCompare(user.email, state.query);
              }).toList();
            } else {
              search = users;
            }

            return Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5), // S/N
                1: FlexColumnWidth(0.5), // icon
                2: FlexColumnWidth(1), // name
                3: FlexColumnWidth(1), // email
                4: FlexColumnWidth(1), // password
                5: FlexColumnWidth(0.5), // delete
              },
              children: [
                TableRow(
                  decoration: tableTitleDecoration(),
                  children: const [
                    TableTitleCell("S/N", textAlign: TextAlign.center),
                    TableTitleCell("Role"),
                    TableTitleCell("Name", textAlign: TextAlign.start),
                    TableTitleCell("Email", textAlign: TextAlign.start),
                    TableTitleCell("Password", textAlign: TextAlign.end),
                    TableTitleCell("Delete", textAlign: TextAlign.center),
                  ],
                ),
                ..._usersTableRowView(search),
              ],
            );
          },
        );
      },
    );
  }

  List<TableRow> _usersTableRowView(List<UserModel> users) {
    return List.generate(
      users.length,
      (index) {
        final UserModel user = users[index];
        return TableRow(
          decoration: tableTextDecoration(index),
          children: [
            TableSNCell(index),
            TableTextCell(user.userRole.label, fontWeight: FontWeight.w800),
            TableTextCell(user.username, fontWeight: FontWeight.w800),
            TableTextCell(user.email),
            TableTextCell(user.password, textAlign: TextAlign.end),
            TableButtonCell(
              icon: Icons.delete,
              iconColor: Colors.red,
              onPressed: () => _deleteUser(user),
            ),
          ],
        );
      },
    );
  }
}
