import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/snackbar.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';

class RegistrationProvider extends ChangeNotifier {
  String userAccountType = "";

  updateUserType(String type) {
    userAccountType = type;
    notifyListeners();
  }

  userType(BuildContext context) {
    if (userAccountType == "") {
      return snackbar(context, 'Please select any one of above');
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NavBar()),
    );
  }
}
