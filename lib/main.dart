import 'package:apos/lib_exp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseFirestore.instance.settings = const Settings(
  //   persistenceEnabled: true,
  // );
  // Ideal time to initialize
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  final db = FirebaseFirestore.instance;
  CacheManager.clear();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => CategoryBloc(database: db)),
        BlocProvider(create: (_) => ProductBloc(database: db)),
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
        child: ProductPage(),
      ),
    );
  }
}



//https://themes.getbootstrap.com/preview/?theme_id=117784
