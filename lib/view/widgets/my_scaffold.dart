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

class MyScaffoldDataGridView extends StatelessWidget {
  final Widget header;
  final BlocBuilder blocBuilder;
  const MyScaffoldDataGridView({
    super.key,
    required this.header,
    required this.blocBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      body: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              header,
              verticalHeight16,
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: blocBuilder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
