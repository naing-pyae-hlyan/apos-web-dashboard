import 'package:apos/lib_exp.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final FloatingActionButton? fab;
  final EdgeInsetsGeometry? padding;
  const MyScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.padding,
    this.fab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.hideKeyboard(),
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Consts.secondaryColor2,
        body: Padding(
          padding: padding ?? const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: body,
        ),
        floatingActionButton: fab,
      ),
    );
  }
}
