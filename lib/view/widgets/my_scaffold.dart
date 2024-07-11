import 'package:apos/lib_exp.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final FloatingActionButton? fab;
  const MyScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: Scaffold(
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: body,
        ),
        floatingActionButton: fab,
      ),
    );
  }
}
