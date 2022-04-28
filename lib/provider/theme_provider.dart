import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkThemeEnabled = false;
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
}

class SpotmiesTheme {
  static bool isDarkMode = false;

  static Color primaryColor = const Color(0xFF006838);

  init(context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    themeProvider.addListener(() {
      isDarkMode = themeProvider.isDarkThemeEnabled;

      primaryColor = const Color(0xFF006838);
    });
  }
}
