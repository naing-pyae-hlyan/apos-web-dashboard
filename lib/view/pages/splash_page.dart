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
    final username = await SpHelper.username;
    final password = await SpHelper.password;

    if (username.isNotEmpty && password.isNotEmpty) {
      authBloc.add(AuthEventLogin(
        username: username,
        password: password,
        rememberMe: true,
      ));
      return;
    }

    if (mounted) context.pushAndRemoveUntil(const LoginPage());
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
      // duration: const Duration(seconds: 1),
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
          if (state is AuthStateSuccess) {
            categoryBloc.add(
              CategoryEventReadData(
                readSuccess: () {
                  context.pushAndRemoveUntil(const HomePage());
                },
              ),
            );
          }
        },
      ),
    );
  }
}
