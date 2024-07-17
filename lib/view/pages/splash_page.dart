import 'package:apos/lib_exp.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    doAfterBuild(
      callback: () {
        context.pushAndRemoveUntil(const LoginPage());
      },
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Consts.secondaryColor,
      body: Center(
        child: myTitle(
          "Hello There",
          fontWeight: FontWeight.bold,
          color: Consts.primaryColor,
          fontSize: 32,
        ),
      ),
    );
  }
}
