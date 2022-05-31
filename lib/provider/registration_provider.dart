import 'package:flutter/material.dart';
import 'package:nandikrushi/model/user.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/view/login/lang_type.dart';
import 'package:nandikrushi/view/login/login.dart';

class RegistrationProvider extends ChangeNotifier {
  String userAccountType = "";
  String langType = "";
  User? user;

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

  updateUser(_) {
    user = _;
    notifyListeners();
  }
}
