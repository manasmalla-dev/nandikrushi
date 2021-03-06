import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/model/user.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushifarmer/view/login/lang_type.dart';
import 'package:nandikrushifarmer/view/login/login.dart';
import 'package:provider/provider.dart';

class RegistrationProvider extends ChangeNotifier {
  String userAccountType = "";
  String langType = "";
  User? user;
  var isLoading = false;

  setLoader(_) {
    isLoading = _;
    notifyListeners();
  }

  var userTypes = [];
  getUserTypes(_) {
    userTypes = _;
    notifyListeners();
  }

  updateUserType(context, String type) {
    userAccountType = type;
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    var userParsedType = type.toLowerCase().contains("farmer")
        ? UserAppTheme.farmer
        : type.toLowerCase().contains("store")
            ? UserAppTheme.store
            : UserAppTheme.restaurant;
    themeProvider.setUserType(userParsedType);
    notifyListeners();
  }

  languegeType(String type) {
    langType = type;
    notifyListeners();
  }

  userType(BuildContext context) {
    if (userAccountType == "") {
      return snackbar(context, 'Please select any one of above');
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LangType()),
    );
  }

  lanType(BuildContext context) {
    if (langType == "") {
      return snackbar(context, 'Please select any one of above');
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const Login()),
    );
  }

  updateUser(_) {
    user = _;
    notifyListeners();
  }
}
