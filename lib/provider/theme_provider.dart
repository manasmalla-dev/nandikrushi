import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserAppTheme { FARMER, RESTERAUNT, STORE }

class ThemeProvider extends ChangeNotifier {
  bool isDarkThemeEnabled = false;
  UserAppTheme userAppTheme = UserAppTheme.FARMER;
  setThemeMode(ThemeMode? themeMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.dark) {
      isDarkThemeEnabled = true;
    } else {
      isDarkThemeEnabled = false;
    }
    await sharedPreferences.setBool("theme_mode", isDarkThemeEnabled);
    notifyListeners();
  }

  updateInitData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var appTheme = sharedPreferences.getString('user_app_theme');
    userAppTheme = appTheme == UserAppTheme.FARMER.toString()
        ? UserAppTheme.FARMER
        : appTheme == UserAppTheme.RESTERAUNT.toString()
            ? UserAppTheme.RESTERAUNT
            : UserAppTheme.STORE;
    notifyListeners();
  }

  setUserType(UserAppTheme appTheme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userAppTheme = appTheme;
    await sharedPreferences.setString(
        "user_app_theme", userAppTheme.toString());
    print(appTheme);
    notifyListeners();
  }
}

class SpotmiesTheme {
  static bool isDarkMode = false;

  static Color primaryColor = const Color(0xFF006838);
  static UserAppTheme appTheme = UserAppTheme.FARMER;

  init(context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    var themeMode = false;
    var userAppTheme = UserAppTheme.FARMER;
    themeProvider.addListener(() {
      themeMode = themeProvider.isDarkThemeEnabled;
      userAppTheme = themeProvider.userAppTheme;
      appTheme = themeProvider.userAppTheme;
      print("Theme Changed: $themeMode");
      print(userAppTheme);
      isDarkMode = themeMode;

      primaryColor = (userAppTheme == UserAppTheme.FARMER
          ? const Color(0xFF006838)
          : userAppTheme == UserAppTheme.RESTERAUNT
              ? const Color(0xFFffd500)
              : const Color(0xFF00bba8));
      print(primaryColor);
    });
  }
}

enum colorScheme {
  background,
  onBackground,
  primary,
  primaryVariant,
  secondary,
  tertiary,
  tertiaryVariant,
  secondaryVariant,
  surface,
  onSurface,
  surfaceVariant,
  surfaceVariant2,
  title,
  titleVariant,
  shadow,
  light1,
  light2,
  light3,
  light4,
  chatBubble,
  chatButton,
  dull
}
