import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension LoginUtils on BuildContext {
  Future<bool> get isReturningUser async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('userID') != null &&
        sharedPreferences.getString('customerID') != null &&
        (sharedPreferences.getString('userID')?.isNotEmpty ?? false) &&
        (sharedPreferences.getString('customerID')?.isNotEmpty ?? false);
  }

  Future<bool> setAsReturningUser(String uId, String cId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userID', uId);
    return sharedPreferences.setString('customerID', cId);
  }
}

String capitalize(String str) {
  return str
      .split(' ')
      .map((word) => word.substring(0, 1).toUpperCase() + word.substring(1))
      .join(' ');
}
