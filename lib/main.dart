import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nandikrushi/firebase_options.dart';
import 'package:nandikrushi/provider/login_provider.dart';
import 'package:nandikrushi/provider/onboard_provider.dart';
import 'package:nandikrushi/provider/registration_provider.dart';
import 'package:nandikrushi/view/login/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark));
    }
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OnboardProvider>(
      create: (context) => OnboardProvider(),
    ),
    ChangeNotifierProvider<RegistrationProvider>(
      create: (context) => RegistrationProvider(),
    ),
    ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nandikrushi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Product Sans',
        useMaterial3: true,
        primaryColor: const Color(0xFF006838),
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Color(0xFF006838),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
