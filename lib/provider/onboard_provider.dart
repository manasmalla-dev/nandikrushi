import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/model/onnboard_model.dart';

class OnboardProvider extends ChangeNotifier {
  dynamic data = onboardData[0];
  int step = 0;

  void increseStep(int num) {
    step += num;
    changeData();
    notifyListeners();
  }

  void changeData() {
    if (step == 1) {
      data = onboardData[1];
    } else {
      data = onboardData[0];
    }
    notifyListeners();
  }

  void setPageNumber(int num) {
    step = num;
    changeData();
    notifyListeners();
  }
}
