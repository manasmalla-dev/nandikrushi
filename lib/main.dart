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

import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future<void> main() async {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      //   systemNavigationBarColor: Colors.white,
      // ));
      //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }
  var data = await getAppTheme();
  //FirebaseAuth.instance.signOut();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginProvider>(
      create: (context) {
        var loginProvider = LoginProvider();

        loginProvider.updateUserAppType(data);
        return loginProvider;
      },
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
          fontFamily: "Product Sans",
          useMaterial3: true,
          colorScheme: loginProvider.isFarmer
              ? const ColorScheme(
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
                )
              : loginProvider.isStore
                  ? ColorScheme(
                      brightness: Brightness.light,
                      primary: Color(0xFF795900),
                      onPrimary: Color(0xFFFFFFFF),
                      primaryContainer: Color(0xFFFFDFA0),
                      onPrimaryContainer: Color(0xFF261A00),
                      secondary: Color(0xFF984061),
                      onSecondary: Color(0xFFFFFFFF),
                      secondaryContainer: Color(0xFFFFD9E2),
                      onSecondaryContainer: Color(0xFF3E001D),
                      tertiary: Color(0xFF4B6546),
                      onTertiary: Color(0xFFFFFFFF),
                      tertiaryContainer: Color(0xFFCCEBC4),
                      onTertiaryContainer: Color(0xFF082008),
                      error: Color(0xFFBA1A1A),
                      errorContainer: Color(0xFFFFDAD6),
                      onError: Color(0xFFFFFFFF),
                      onErrorContainer: Color(0xFF410002),
                      background: Color(0xFFFFFBFF),
                      onBackground: Color(0xFF1E1B16),
                      surface: Color(0xFFFFFBFF),
                      onSurface: Color(0xFF1E1B16),
                      surfaceVariant: Color(0xFFEDE1CF),
                      onSurfaceVariant: Color(0xFF4D4639),
                      outline: Color(0xFF7F7667),
                      onInverseSurface: Color(0xFFF8EFE7),
                      inverseSurface: Color(0xFF34302A),
                      inversePrimary: Color(0xFFFBBC05),
                      shadow: Color(0xFF000000),
                      surfaceTint: Color(0xFF795900),
                    )
                  : ColorScheme(
                      brightness: Brightness.light,
                      primary: Color(0xFF006B5F),
                      onPrimary: Color(0xFFFFFFFF),
                      primaryContainer: Color(0xFF6BF9E4),
                      onPrimaryContainer: Color(0xFF00201C),
                      secondary: Color(0xFF4A635E),
                      onSecondary: Color(0xFFFFFFFF),
                      secondaryContainer: Color(0xFFCCE8E2),
                      onSecondaryContainer: Color(0xFF06201C),
                      tertiary: Color(0xFF456179),
                      onTertiary: Color(0xFFFFFFFF),
                      tertiaryContainer: Color(0xFFCBE6FF),
                      onTertiaryContainer: Color(0xFF001E30),
                      error: Color(0xFFBA1A1A),
                      errorContainer: Color(0xFFFFDAD6),
                      onError: Color(0xFFFFFFFF),
                      onErrorContainer: Color(0xFF410002),
                      background: Color(0xFFFAFDFB),
                      onBackground: Color(0xFF191C1B),
                      surface: Color(0xFFFAFDFB),
                      onSurface: Color(0xFF191C1B),
                      surfaceVariant: Color(0xFFDAE5E1),
                      onSurfaceVariant: Color(0xFF3F4946),
                      outline: Color(0xFF6F7976),
                      onInverseSurface: Color(0xFFEFF1EF),
                      inverseSurface: Color(0xFF2D3130),
                      inversePrimary: Color(0xFF48DCC8),
                      shadow: Color(0xFF000000),
                      surfaceTint: Color(0xFF006B5F),
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
