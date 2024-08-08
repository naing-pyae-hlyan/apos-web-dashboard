import 'package:apos/lib_exp.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldDataGridView<QuerySnapshot<UserModel>>(
      stream: stream,
      streamBuilder: streamBuilder,
    );
  }
}
