import 'package:apos/lib_exp.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final Color? cardColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  const MyCard({
    super.key,
    required this.child,
    this.cardColor,
    this.shadowColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor ?? Colors.white,
      surfaceTintColor: cardColor ?? Colors.white,
      shadowColor: shadowColor ?? Consts.secondaryColor,
      elevation: 16,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
