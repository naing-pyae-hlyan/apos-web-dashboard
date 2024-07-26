import 'dart:convert';

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

class TableImagesCell extends StatelessWidget {
  final List<String> images;
  const TableImagesCell({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
        ? const TableTextCell("no-images")
        : TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                runAlignment: WrapAlignment.start,
                children: images
                    .map(
                      (String image) => Image.memory(
                        base64Decode(image),
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }
}

class TableTextCell extends StatelessWidget {
  final String? label;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? padding;
  final TableCellVerticalAlignment verticalAlignment;
  final int maxLines;
  const TableTextCell(
    this.label, {
    super.key,
    this.padding,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.verticalAlignment = TableCellVerticalAlignment.middle,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: verticalAlignment,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: myText(
          label,
          textAlign: textAlign,
          fontWeight: fontWeight,
          maxLines: maxLines,
        ),
      ),
    );
  }
}

class TableStatusCell extends StatelessWidget {
  final OrderStatus status;
  final Function() onPressed;
  const TableStatusCell({
    super.key,
    required this.status,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Clickable(
        onTap: onPressed,
        radius: 32,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: status.color,
            borderRadius: BorderRadius.circular(32),
          ),
          child: myText(
            status.name,
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
