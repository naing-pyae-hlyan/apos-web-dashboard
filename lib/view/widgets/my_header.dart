import 'package:apos/lib_exp.dart';

class MyHeader extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  const MyHeader({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        myTitle(title),
        horizontalWidth8,
        if (actions != null)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: actions!,
            ),
          ),
      ],
    );
  }
}
