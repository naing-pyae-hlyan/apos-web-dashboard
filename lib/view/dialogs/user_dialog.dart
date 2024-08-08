import 'package:apos/lib_exp.dart';
import 'package:apos/view/pages/users/_exp.dart';

void showUserDialog(BuildContext context) => showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const _UserDialog(),
    );

const _userNameErrorKey = "user-name-error-key";
const _userEmailErrorKey = "user-email-error-key";
const _userPasswordErrorKey = "user-password-error-key";

class _UserDialog extends StatefulWidget {
  const _UserDialog();

  @override
  State<_UserDialog> createState() => __UserDialogState();
}

class __UserDialogState extends State<_UserDialog> {
  late UsersBloc usersBloc;
  late ErrorBloc errorBloc;

  final _userNameTxtCtrl = TextEditingController();
  final _userEmailTxtCtrl = TextEditingController();
  final _userPasswordTxtCtrl = TextEditingController();
  final _userNameFn = FocusNode();
  final _userEmailFn = FocusNode();
  final _userPasswordFn = FocusNode();

  int _selectedRole = 0;

  void _onSave() {
    final name = _userNameTxtCtrl.text;
    final email = _userEmailTxtCtrl.text;
    final password = _userPasswordTxtCtrl.text;

    usersBloc.add(UsersEventCreate(
      user: UserModel(
        readableId: RandomIdGenerator.generateUniqueId(),
        username: name,
        email: email,
        password: HashUtils.hashPassword(password),
        role: _selectedRole,
        userRole: parseUserRole(_selectedRole),
      ),
    ));
  }

  @override
  void initState() {
    usersBloc = context.read<UsersBloc>();
    errorBloc = context.read<ErrorBloc>();

    super.initState();

    doAfterBuild(callback: () {
      _userNameFn.requestFocus();
      errorBloc.add(ErrorEventResert());
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _userNameTxtCtrl.dispose();
      _userEmailTxtCtrl.dispose();
      _userPasswordTxtCtrl.dispose();
      _userNameFn.dispose();
      _userEmailFn.dispose();
      _userPasswordFn.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = context.screenWidth * 0.3;
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Consts.secondaryColor,
      title: Center(child: myTitle('Add User')),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInputField(
                controller: _userNameTxtCtrl,
                focusNode: _userNameFn,
                title: "Username",
                hintText: "Enter Name",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                errorKey: _userNameErrorKey,
              ),
              verticalHeight16,
              MyInputField(
                controller: _userEmailTxtCtrl,
                focusNode: _userEmailFn,
                title: "Email",
                hintText: "Enter email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                errorKey: _userEmailErrorKey,
              ),
              verticalHeight16,
              MyPasswordInputField(
                controller: _userPasswordTxtCtrl,
                focusNode: _userPasswordFn,
                title: "New Password",
                hintText: "New Password",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                errorKey: _userPasswordErrorKey,
                onSubmitted: (String str) {},
              ),
              verticalHeight16,
              UserRoleSelectionView(
                oldRole: null,
                onSelectedRole: (int role) {
                  _selectedRole = role;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: myText('Cancel'),
        ),
        BlocConsumer<UsersBloc, UsersState>(
          builder: (_, UsersState state) {
            if (state is UsersStateLoading) {
              return const MyCircularIndicator();
            }

            return MyButton(
              label: "Save",
              icon: Icons.save,
              onPressed: _onSave,
            );
          },
          listener: (_, UsersState state) {
            if (state is UsersStateCreateSuccess ||
                state is UsersStateUpdateSuccess) {
              context.pop();
            }

            if (state is UsersStateFail) {
              if (state.error.code == 1) {
                errorBloc.add(ErrorEventSetError(
                  errorKey: _userNameErrorKey,
                  error: state.error,
                ));
                _userNameFn.requestFocus();
                return;
              }

              if (state.error.code == 2) {
                errorBloc.add(ErrorEventSetError(
                  errorKey: _userEmailErrorKey,
                  error: state.error,
                ));
                _userEmailFn.requestFocus();

                return;
              }
              if (state.error.code == 3) {
                errorBloc.add(ErrorEventSetError(
                  errorKey: _userPasswordErrorKey,
                  error: state.error,
                ));
                _userPasswordFn.requestFocus();

                return;
              }
            }
          },
        ),
      ],
    );
  }
}
