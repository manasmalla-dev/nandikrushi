import 'dart:developer';

import 'package:mvc_pattern/mvc_pattern.dart';

class CartController extends ControllerMVC {
  Map<int, int> addedProductQuantity = {};

  Map<int, int> addedDashboardProductQuantity = {};
  var items = [
    {
      'name': 'Tomato',
      'unit': '1 kg',
      'price': '50',
      'quantity': '10',
      'place': 'Paravada, Visakhapatnam.',
      'url':
          'https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg'
    },
    {
      'name': 'Foxtail Millet',
      'unit': '1 kg',
      'price': '140',
      'quantity': '25',
      'place': 'Paravada, Visakhapatnam.',
      'url':
          'https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg'
    }
  ];
  updateCart() {
    var body = items.join();
    log(body.toString());

    /*var resp =
        await Server().postMethodParems(jsonEncode(body)).catchError((e) {
      log("64" + e.toString());
    });
    
    log(resp.body.toString());*/
  }
}
