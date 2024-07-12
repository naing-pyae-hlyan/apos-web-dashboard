import 'package:apos/lib_exp.dart';

class MyHeader extends StatelessWidget {
  final String title;
  final String addBtnTitle;
  final Function() onTapAdd;
  const MyHeader({
    super.key,
    required this.title,
    this.addBtnTitle = "Add",
    required this.onTapAdd,
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
        MyButton(
          label: addBtnTitle,
          onPressed: onTapAdd,
        ),
      ],
    );
  }
}
