import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nandikrushifarmer/provider/login_provider.dart';
import 'package:nandikrushifarmer/provider/onboard_provider.dart';
import 'package:nandikrushifarmer/provider/registration_provider.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/view/login/registration.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
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
        primaryColor: const Color(0xFF006838),
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Color(0xFF006838),
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}
