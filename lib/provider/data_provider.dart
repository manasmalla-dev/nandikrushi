import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  var categories = [];
  var gotOrders = false;
  var orders = [];
  addCategories(_) {
    categories = _;
    notifyListeners();
  }

  addOrders(_) {
    orders = _;
    gotOrders = true;
    notifyListeners();
  }
}
