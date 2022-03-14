import 'package:flutter/material.dart';

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

dynamic onboardData = [
  {
    "imageLink":
        "https://climate.copernicus.eu/sites/default/files/styles/hero_image_extra_large_2x/public/2018-07/globalagriculture.jpg?itok=fUmFHs6s",
    "content": [
      "No natural farmers's should suffered to sell thier product, in their locality",
      "Maximizing farmer's profit and reducing by buying directly from them"
    ],
    "title": "Transparency",
    "button_name": "NEXT",
  },
  {
    "imageLink":
        "https://climate.copernicus.eu/sites/default/files/styles/hero_image_extra_large_2x/public/2018-07/globalagriculture.jpg?itok=fUmFHs6s",
    "content": [
      "Nandi Krushi, Building blockchain based network for traceability of organic product to stop fake organic / adulterated products creeping into supply chain with organic labels.\n\nHere provenance framework will be used so that farmers and end consumers will be the ultimate gainers disrupting multi level middle men in organic supply chain",
    ],
    "title": "Traceability",
    "button_name": "GET STARTED"
  }
];
