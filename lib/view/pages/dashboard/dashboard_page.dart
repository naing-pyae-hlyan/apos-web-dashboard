import 'package:apos/lib_exp.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [myText("Dashboard")],
      ),
    );
  }
}
