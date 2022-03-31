import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushifarmer/view/login/lang_type.dart';
import 'package:nandikrushifarmer/view/login/login.dart';

class RegistrationProvider extends ChangeNotifier {
  String userAccountType = "";
  String langType = "";

  updateUserType(String type) {
    userAccountType = type;
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
}
