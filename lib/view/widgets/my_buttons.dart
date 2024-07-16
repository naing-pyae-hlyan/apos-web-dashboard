import 'package:apos/lib_exp.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Color? backgroundColor;
  final Function() onPressed;
  final Color? borderColor;
  const MyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: myText(
        label,
        color: labelColor ?? Consts.primaryColor,
        fontWeight: FontWeight.bold,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Consts.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            width: 0.5,
            color: borderColor ?? Consts.primaryColor,
          ),
        ),
      ),
    );
  }
}
