import 'dart:convert';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

class MyProductsController extends ControllerMVC {
  var url =
      "http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/sellerproduct/GetSellerproductdata";

  List list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        var listItems = jsonDecode(response.body)["message"];
        list.addAll(listItems);
      }
    });
  }
}
