import 'package:apos/lib_exp.dart';

void showOrderStatusChangeDialog(
  BuildContext context, {
  required Order order,
  required Function(int) onStatusIdChanged,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => OrderStatusChangeDialog(
        order: order,
        onStausIdChanged: onStatusIdChanged,
      ),
    );

class OrderStatusChangeDialog extends StatefulWidget {
  final Order order;
  final Function(int) onStausIdChanged;
  const OrderStatusChangeDialog({
    super.key,
    required this.order,
    required this.onStausIdChanged,
  });

  @override
  State<OrderStatusChangeDialog> createState() =>
      _OrderStatusChangeDialogState();
}

class _OrderStatusChangeDialogState extends State<OrderStatusChangeDialog> {
  List<Widget> _generateTile() {
    final List<Widget> tiles = [];
    switch (parseToOrderStatus(widget.order.statusId)) {
      case OrderStatus.newOrder:
        tiles.addAll([
          _getTile(OrderStatus.cancelled),
          _getTile(OrderStatus.processing),
        ]);
        break;
      case OrderStatus.cancelled:
        tiles.add(_getTile(OrderStatus.processing));
        break;
      case OrderStatus.processing:
        tiles.addAll([
          _getTile(OrderStatus.cancelled),
          _getTile(OrderStatus.delivered),
        ]);
        break;
      case OrderStatus.delivered:
        break;
    }
    return tiles;
  }

  Widget _getTile(OrderStatus status) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextButton.icon(
          onPressed: () {
            context.pop();
            widget.onStausIdChanged(status.code);
          },
          style: TextButton.styleFrom(
            side: const BorderSide(width: 0.5),
          ),
          label: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                myTitle(status.value),
                Icon(
                  parseOrderStatusToIcon(status.index),
                  color: parseOrderStatusToColor(status.index),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Column(
        children: [
          myTitle("Order ID : ${widget.order.id}"),
          verticalHeight4,
          myText("(${parseToOrderStatus(widget.order.statusId).name})"),
        ],
      ),
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: _generateTile(),
      ),
    );
  }
}
