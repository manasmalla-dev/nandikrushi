import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension LoginUtils on BuildContext {
  Future<bool> get isReturningUser async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isReturningUser') ?? false;
  }

  Future<bool> get setAsReturningUser async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool('isReturningUser', true);
  }
}

String capitalize(String str) {
  return str
      .split(' ')
      .map((word) => word.substring(0, 1).toUpperCase() + word.substring(1))
      .join(' ');
}
