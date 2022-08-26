import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/firebase_options.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/splash_screen.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
    ),
    // ChangeNotifierProvider<OnboardProvider>(
    //   create: (context) => OnboardProvider(),
    // ),
    // ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
    // ChangeNotifierProvider<RegistrationProvider>(
    //   create: (context) => RegistrationProvider(),
    // ),
    // ChangeNotifierProvider<LoginProvider>(
    //   create: (context) => LoginProvider(),
    // ),
    // ChangeNotifierProvider<UniversalProvider>(
    //   create: (context) => UniversalProvider(),
    // ),
    // ChangeNotifierProvider<SellerProductProvider>(
    //   create: (context) => SellerProductProvider(),
    // ),
    // ChangeNotifierProvider<ProfileProvider>(
    //   create: (context) => ProfileProvider(),
    // ),
    // ChangeNotifierProvider<GetAllProductsProvider>(
    //   create: (context) => GetAllProductsProvider(),
    // ),
    // ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider())
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
          primarySwatch: createMaterialColor(loginProvider.userAppTheme.value),
          fontFamily: "Product Sans",
          useMaterial3: true,
        ),
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

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Nandikrushi Farmer"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         tooltip: 'Increment',
//         child: const Icon(Icons.add_rounded),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
