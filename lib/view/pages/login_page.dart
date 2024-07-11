import 'package:apos/lib_exp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Center(
        child: SizedBox(
          width: context.screenWidth * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myText("Welcome", fontSize: 64),
              verticalHeight64,
              MyInputField(
                controller: TextEditingController(),
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              verticalHeight16,
              MyPasswordInputField(
                controller: TextEditingController(),
                hintText: "Enter your password",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                onSubmitted: (String str) {},
              ),
              verticalHeight32,
              ElevatedButton(
                onPressed: () {
                  context.pushAndRemoveUntil(const HomePage());
                },
                child: myText("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
