import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/firebase_options.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/splash_screen.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //FirebaseAuth.instance.signOut();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
    ),
    ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
    ),
    ChangeNotifierProvider<ProfileProvider>(
      create: (context) => ProfileProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nandikrushi Farmer',
        theme: ThemeData(
            primarySwatch:
                createMaterialColor(loginProvider.userAppTheme.value),
            fontFamily: "Product Sans",
            useMaterial3: true,
            brightness: Brightness.light),
        darkTheme: ThemeData(
          backgroundColor: Colors.grey.shade900,
          primarySwatch: createMaterialColor(
              createMaterialColor(loginProvider.userAppTheme.value).shade100),
          fontFamily: "Product Sans",
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      );
    });
  }
}
