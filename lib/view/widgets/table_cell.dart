import 'package:apos/lib_exp.dart';

class TableTitleCell extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  const TableTitleCell(
    this.label, {
    super.key,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: myTitle(label, textAlign: textAlign),
      ),
    );
  }
}

class TableTextCell extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  const TableTextCell(
    this.label, {
    super.key,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: myText(label, textAlign: textAlign),
      ),
    );
  }
}

class TableButtonCell extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color? iconColor;
  const TableButtonCell({
    super.key,
    required this.icon,
    this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
      ),
    );
  }
}
