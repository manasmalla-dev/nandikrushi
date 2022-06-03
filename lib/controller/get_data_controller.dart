import 'dart:convert';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:nandikrushifarmer/provider/data_provider.dart';
import 'package:provider/provider.dart';

class GetDataController extends ControllerMVC {
  getCategories(context) {
    var uri = Uri.tryParse(
        'http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/getsubcategories');
    if (uri == null) {
      return;
    }
    http.get(uri).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> jsonDecoded = jsonDecode(response.body)["message"];
        var cateogies = jsonDecoded.map((e) => e["category_name"]);
        var provider = Provider.of<DataProvider>(context, listen: false);
        provider.addCategories(cateogies);
      }
    });
  }
}
