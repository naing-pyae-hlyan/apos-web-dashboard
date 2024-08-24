import 'dart:convert';

import 'package:apos/lib_exp.dart';

void showBankPaymentDialog(
  BuildContext context, {
  required OrderModel order,
}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => _BankPaymentDialog(order: order),
    );

class _BankPaymentDialog extends StatelessWidget {
  final OrderModel order;
  const _BankPaymentDialog({required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Consts.secondaryColor,
      contentPadding: const EdgeInsets.all(16),
      title: Center(child: myTitle("Order ID : ${order.readableId}")),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            myTitle("Pay By : ${order.payment}"),
            verticalHeight16,
            if (order.paymentSS != null)
              Image.memory(
                base64Decode(order.paymentSS ?? ""),
                fit: BoxFit.contain,
                width: context.screenWidth * 0.25,
                errorBuilder: (_, __, ___) => emptyUI,
              ),
          ],
        ),
      ),
    );
  }
}
