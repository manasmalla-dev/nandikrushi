import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nandikrushi/model/dummy_model.dart';
import 'package:nandikrushi/repo/api_status.dart';

class Network {
  static Future<Object> getDummy() async {
    try {
      var uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        return Success(response: userModelFromJson(response.body));
      }

      return Failure(code: 100, errorResponse: 'Invali Response');
    } on HttpException {
      return Failure(code: 101, errorResponse: 'Invali Response');
    } on FormatException {
      return Failure(code: 102, errorResponse: 'Invali Response');
    } catch (e) {
      return Failure(code: 103, errorResponse: 'Invali Response');
    }
  }
}
