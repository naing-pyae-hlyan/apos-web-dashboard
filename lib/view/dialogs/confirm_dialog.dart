import 'package:apos/lib_exp.dart';

void showConfirmDialog(
  BuildContext context, {
  required String title,
  String? description,
  Function()? onTapCancel,
  required Function() onTapOk,
}) =>
    showAdaptiveDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        title: title,
        description: description,
        onTapCancel: onTapCancel,
        onTapOk: onTapOk,
      ),
    );

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String? description;
  final Function()? onTapCancel;
  final Function() onTapOk;
  const ConfirmDialog({
    super.key,
    required this.title,
    this.description,
    this.onTapCancel,
    required this.onTapOk,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: myTitle(title),
      content: myText(description, maxLines: 4),
      actions: [
        TextButton(
          onPressed: () {
            if (onTapCancel != null) {
              onTapCancel!();
            }
            Navigator.of(context).pop();
          },
          child: myText('Cancel'),
        ),
        MyButton(
          label: "Delete",
          labelColor: Colors.red,
          borderColor: Colors.red,
          onPressed: () {
            onTapOk();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
