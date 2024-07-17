import 'package:apos/lib_exp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => OrderBloc()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Consts.primaryColor,
      ),
      home: const SafeArea(
        child: SplashPage(),
      ),
    );
  }
}



//https://themes.getbootstrap.com/preview/?theme_id=117784
