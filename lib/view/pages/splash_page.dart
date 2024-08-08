import 'package:apos/lib_exp.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AuthBloc authBloc;
  late CategoryBloc categoryBloc;

  Future<void> _checkCredentials() async {
    final email = await SpHelper.email;
    final password = await SpHelper.password;

    authBloc.add(AuthEventLogin(
      email: email,
      password: password,
      rememberMe: true,
    ));
  }

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    categoryBloc = context.read<CategoryBloc>();

    super.initState();
    doAfterBuild(
      callback: () async {
        await _checkCredentials();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Consts.secondaryColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (_, AuthState state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                myTitle(
                  "Hello There",
                  fontWeight: FontWeight.bold,
                  color: Consts.primaryColor,
                  fontSize: 86,
                ),
                verticalHeight32,
                LoadingAnimationWidget.threeArchedCircle(
                  color: Consts.primaryColor,
                  size: 50,
                ),
              ],
            ),
          );
        },
        listener: (_, AuthState state) {
          if (state is AuthStateLoginSuccess) {
            categoryBloc.add(
              CategoryEventReadData(
                readSuccess: () {
                  context.pushAndRemoveUntil(const HomePage());
                },
              ),
            );
          }
          if (state is AuthStateFail) {
            context.pushAndRemoveUntil(const LoginPage());
          }
        },
      ),
    );
  }
}
