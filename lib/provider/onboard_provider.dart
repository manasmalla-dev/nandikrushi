import 'package:flutter/material.dart';

class OnboardProvider extends ChangeNotifier {
  dynamic data = onboardData[0];
  int step = 0;

  void increseStep(int num) {
    step = num;
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
}

dynamic onboardData = [
  {
    "imageLink":
        "https://climate.copernicus.eu/sites/default/files/styles/hero_image_extra_large_2x/public/2018-07/globalagriculture.jpg?itok=fUmFHs6s",
    "content": [
      "No natural farmers's should suffered to sell thier product, in their locality",
      "Maximizing farmer's profit and reducingby by buying directly from them"
    ],
    "title": "Transparency",
    "button_name": "NEXT"
  },
  {
    "imageLink":
        "https://climate.copernicus.eu/sites/default/files/styles/hero_image_extra_large_2x/public/2018-07/globalagriculture.jpg?itok=fUmFHs6s",
    "content": [
      "yes natural farmers's should suffered to sell thier product, in their locality",
      "Maximizing farmer's profit and reducingby by buying directly from them"
    ],
    "title": "Transparency",
    "button_name": "CLOSE"
  }
];
