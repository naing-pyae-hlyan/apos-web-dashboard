import 'package:apos/lib_exp.dart';

enum OrderStatus {
  cancelled(code: 0, name: "Cancelled"),
  processing(code: 1, name: "Processing"),
  finished(code: 2, name: "Finished");

  final int code;
  final String name;
  const OrderStatus({required this.code, required this.name});
}

OrderStatus parseToOrderStatus(int code) => code == 0
    ? OrderStatus.cancelled
    : code == 1
        ? OrderStatus.processing
        : code == 2
            ? OrderStatus.finished
            : OrderStatus.processing;

Color parseOrderStatusToColor(int code) => code == 0
    ? Colors.grey
    : code == 1
        ? Colors.amber
        : code == 2
            ? Colors.green
            : Colors.transparent;
