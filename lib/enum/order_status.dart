import 'package:apos/lib_exp.dart';

enum OrderStatus {
  newOrder(code: 0, name: "New Order", value: ""),
  cancelled(code: 1, name: "Cancelled", value: "Cancel"),
  processing(code: 2, name: "Processing", value: "Process"),
  delivered(code: 3, name: "Delivered", value: "Finish");

  final int code;
  final String name;
  final String value;
  const OrderStatus({
    required this.code,
    required this.name,
    required this.value,
  });
}

OrderStatus parseToOrderStatus(int code) => code == 0
    ? OrderStatus.newOrder
    : code == 1
        ? OrderStatus.cancelled
        : code == 2
            ? OrderStatus.processing
            : OrderStatus.delivered;

Color parseOrderStatusToColor(int code) => code == 0
    ? Colors.indigo
    : code == 1
        ? Colors.grey
        : code == 2
            ? Colors.amber
            : Colors.green;

IconData parseOrderStatusToIcon(int code) => code == 0
    ? Icons.add
    : code == 1
        ? Icons.cancel_rounded
        : code == 2
            ? Icons.rocket_launch_rounded
            : Icons.done_all;
