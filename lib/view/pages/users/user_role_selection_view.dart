import 'package:apos/lib_exp.dart';

class UserRoleSelectionView extends StatefulWidget {
  final int? oldRole;
  final Function(int) onSelectedRole;
  const UserRoleSelectionView({
    super.key,
    required this.oldRole,
    required this.onSelectedRole,
  });

  @override
  State<UserRoleSelectionView> createState() => _UserRoleSelectionViewState();
}

class _UserRoleSelectionViewState extends State<UserRoleSelectionView> {
  int _selectedRadioTile = 0;

  @override
  void initState() {
    _selectedRadioTile = widget.oldRole ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        verticalHeight16,
        myText("Role", fontWeight: FontWeight.w800),
        verticalHeight8,
        ...UserRoleEnum.values.map((UserRoleEnum ure) {
          return RadioListTile<int>(
            value: ure.role,
            title: myText(ure.label),
            contentPadding: EdgeInsets.zero,
            groupValue: _selectedRadioTile,
            onChanged: (int? val) {
              setState(() {
                _selectedRadioTile = val ?? 0;
              });
              widget.onSelectedRole(_selectedRadioTile);
            },
          );
        }),
      ],
    );
  }
}
