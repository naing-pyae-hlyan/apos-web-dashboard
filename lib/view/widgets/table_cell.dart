import 'package:apos/lib_exp.dart';

class TableTitleCell extends StatelessWidget {
  final String label;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;
  const TableTitleCell(
    this.label, {
    super.key,
    this.padding,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: myTitle(label, textAlign: textAlign),
      ),
    );
  }
}

class TableSNCell extends StatelessWidget {
  final int index;
  const TableSNCell(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return TableTextCell(
      "${index + 1}",
      textAlign: TextAlign.center,
    );
  }
}

class TableTextCell extends StatelessWidget {
  final String? label;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? padding;
  const TableTextCell(
    this.label, {
    super.key,
    this.padding,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: myText(label, textAlign: textAlign, fontWeight: fontWeight),
      ),
    );
  }
}

class TableStatusCell extends StatelessWidget {
  final int statusId;
  const TableStatusCell({
    super.key,
    required this.statusId,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Clickable(
        onTap: () {
          print("object");
        },
        radius: 32,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
          decoration: BoxDecoration(
            color: parseOrderStatusToColor(statusId),
            borderRadius: BorderRadius.circular(32),
          ),
          child: myText(
            parseToOrderStatus(statusId).name,
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TableCustomerCell extends StatelessWidget {
  final String id;
  final String name;
  const TableCustomerCell({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            myText(name),
            myText(id, fontSize: 11),
          ],
        ),
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

class TableTitleItemsDialogCell extends StatelessWidget {
  const TableTitleItemsDialogCell({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myTitle("Items"),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1),
              },
              children: const [
                TableRow(
                  children: [
                    TableTextCell("Qty", fontWeight: FontWeight.bold),
                    TableTextCell("Item", fontWeight: FontWeight.bold),
                    TableTextCell(
                      "Amount",
                      textAlign: TextAlign.end,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TableProductItemsCell extends StatelessWidget {
  final List<Item> items;
  const TableProductItemsCell({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    List<String> labels = [];
    for (Item item in items) {
      labels.add(item.name);
    }
    return TableTextCell(labels.join(", "));
  }
}

class TableProductItemsDialogCell extends StatelessWidget {
  final List<Item> items;
  const TableProductItemsDialogCell({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(0.5),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1),
          },
          children: items.map(
            (Item item) {
              return TableRow(
                children: [
                  TableTextCell("${item.quantity}"),
                  TableTextCell(item.name),
                  TableTextCell(
                    item.amount.toCurrencyFormat(),
                    textAlign: TextAlign.end,
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

Decoration tableTitleDecoration() => BoxDecoration(
      border: Border.all(
        color: Consts.primaryColor,
        width: 0.3,
      ),
    );

Decoration tableTextDecoration(int index) => BoxDecoration(
      color: index.isOdd ? Consts.primaryColor.withOpacity(0.1) : Colors.white,
    );
