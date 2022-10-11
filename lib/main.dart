import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
      ));
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }
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
          primarySwatch: createMaterialColor(loginProvider.userAppTheme.value),
          fontFamily: "Product Sans",
          useMaterial3: true,
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF006D3B),
            onPrimary: Color(0xFFFFFFFF),
            primaryContainer: Color(0xFF99F7B5),
            onPrimaryContainer: Color(0xFF00210E),
            secondary: Color(0xFF4F6353),
            onSecondary: Color(0xFFFFFFFF),
            secondaryContainer: Color(0xFFD2E8D4),
            onSecondaryContainer: Color(0xFF0D1F13),
            tertiary: Color(0xFF3A646F),
            onTertiary: Color(0xFFFFFFFF),
            tertiaryContainer: Color(0xFFBEEAF6),
            onTertiaryContainer: Color(0xFF001F26),
            error: Color(0xFFBA1A1A),
            errorContainer: Color(0xFFFFDAD6),
            onError: Color(0xFFFFFFFF),
            onErrorContainer: Color(0xFF410002),
            background: Color(0xFFFBFDF8),
            onBackground: Color(0xFF191C19),
            surface: Color(0xFFFBFDF8),
            onSurface: Color(0xFF191C19),
            surfaceVariant: Color(0xFFDDE5DB),
            onSurfaceVariant: Color(0xFF414942),
            outline: Color(0xFF717971),
            onInverseSurface: Color(0xFFF0F1EC),
            inverseSurface: Color(0xFF2E312E),
            inversePrimary: Color(0xFF7DDA9B),
            shadow: Color(0xFF000000),
            surfaceTint: Color(0xFF006D3B),
          ),
        ),
        darkTheme: ThemeData(
          backgroundColor: Colors.grey.shade900,
          primarySwatch: createMaterialColor(
              createMaterialColor(loginProvider.userAppTheme.value).shade100),
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xFF7DDA9B),
            onPrimary: Color(0xFF00391C),
            primaryContainer: Color(0xFF00522B),
            onPrimaryContainer: Color(0xFF99F7B5),
            secondary: Color(0xFFB6CCB8),
            onSecondary: Color(0xFF223527),
            secondaryContainer: Color(0xFF384B3C),
            onSecondaryContainer: Color(0xFFD2E8D4),
            tertiary: Color(0xFFA2CEDA),
            onTertiary: Color(0xFF023640),
            tertiaryContainer: Color(0xFF214C57),
            onTertiaryContainer: Color(0xFFBEEAF6),
            error: Color(0xFFFFB4AB),
            errorContainer: Color(0xFF93000A),
            onError: Color(0xFF690005),
            onErrorContainer: Color(0xFFFFDAD6),
            background: Color(0xFF191C19),
            onBackground: Color(0xFFE1E3DE),
            surface: Color(0xFF191C19),
            onSurface: Color(0xFFE1E3DE),
            surfaceVariant: Color(0xFF414942),
            onSurfaceVariant: Color(0xFFC1C9BF),
            outline: Color(0xFF8B938A),
            onInverseSurface: Color(0xFF191C19),
            inverseSurface: Color(0xFFE1E3DE),
            inversePrimary: Color(0xFF006D3B),
            shadow: Color(0xFF000000),
            surfaceTint: Color(0xFF7DDA9B),
          ),
          fontFamily: "Product Sans",
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF191C19),
        ),
        home: const SplashScreen(),
      );
    });
  }
}
