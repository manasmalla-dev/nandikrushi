import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserAppTheme { farmer, restaurant, store }

class ThemeProvider extends ChangeNotifier {
  bool isDarkThemeEnabled = false;
  UserAppTheme userAppTheme = UserAppTheme.farmer;
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
    userAppTheme = appTheme == UserAppTheme.farmer.toString()
        ? UserAppTheme.farmer
        : appTheme == UserAppTheme.restaurant.toString()
            ? UserAppTheme.restaurant
            : UserAppTheme.store;
    notifyListeners();
  }

  setUserType(UserAppTheme appTheme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userAppTheme = appTheme;
    await sharedPreferences.setString(
        "user_app_theme", userAppTheme.toString());
    notifyListeners();
  }
}

dynamic dualParamTheme(var state1, var state2, int condition) {
  //Condition 1 - Farmer
  //Contion 2 - Restaurant
  //Condition 3 - Store
  dynamic param1 = 0;
  dynamic param2 = 0;
  if (condition == 1) {}
  return [param1, param2];
}

class SpotmiesTheme {
  static bool isDarkMode = false;

  static Color primaryColor = const Color(0xFF006838);
  static UserAppTheme appTheme = UserAppTheme.farmer;

  init(context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    themeProvider.addListener(() {
      isDarkMode = themeProvider.isDarkThemeEnabled;
      appTheme = themeProvider.userAppTheme;

      primaryColor = (appTheme == UserAppTheme.farmer
          ? const Color(0xFF006838)
          : appTheme == UserAppTheme.restaurant
              ? const Color(0xFFffd500)
              : const Color(0xFF00bba8));
    });
  }
}
