import 'package:apos/lib_exp.dart';

void showOrderStatusChangeDialog(
  BuildContext context, {
  required OrderModel order,
  required Function(int) onStatusIdChanged,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _OrderStatusChangeDialog(
        order: order,
        onStausIdChanged: onStatusIdChanged,
      ),
    );

class _OrderStatusChangeDialog extends StatefulWidget {
  final OrderModel order;
  final Function(int) onStausIdChanged;
  const _OrderStatusChangeDialog({
    required this.order,
    required this.onStausIdChanged,
  });

  @override
  State<_OrderStatusChangeDialog> createState() =>
      _OrderStatusChangeDialogState();
}

class _OrderStatusChangeDialogState extends State<_OrderStatusChangeDialog> {
  List<Widget> _generateTile() {
    final List<Widget> tiles = [];

    switch (widget.order.status) {
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
        tiles.addAll([
          _getTile(OrderStatus.cancelled),
          _getTile(OrderStatus.processing),
        ]);
        // TODO remove
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                myTitle(status.value),
                Icon(status.icon, color: status.color),
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
      shadowColor: Consts.secondaryColor,
      title: Column(
        children: [
          myTitle("Order ID : ${widget.order.id}"),
          verticalHeight4,
          myText(widget.order.status.name),
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
