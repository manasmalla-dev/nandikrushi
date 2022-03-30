import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nandikrushi/repo/api_exceptions.dart';
import 'package:nandikrushi/repo/api_urls.dart';

class Server {
  Future<dynamic> getMethod(String api) async {
    var uri = Uri.https(API.host, api);

    try {
      var response = await http.get(uri).timeout(const Duration(seconds: 30));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          'API Not Responding in Time', uri.toString());
    }
  }

  Future<dynamic> postMethod(String api, Map<String, dynamic> body) async {
    var uri = Uri.https(API.host, api);
    // var bodyData = json.encode(body);
    try {
      var response =
          await http.post(uri, body: body).timeout(const Duration(seconds: 30));

      // return processResponse(response);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          'API Not Responding in Time', uri.toString());
    }
  }

  Future<dynamic> editMethod(String api, Map<String, dynamic> body) async {
    var uri = Uri.https(API.host, api);
    // var bodyData = json.encode(body);
    try {
      var response =
          await http.put(uri, body: body).timeout(const Duration(seconds: 30));
      // print("45 $response");

      return processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          'API Not Responding in Time', uri.toString());
    }
  }

  Future<dynamic> deleteMethod(String api) async {
    var uri = Uri.https(API.host, api);

    try {
      var response =
          await http.delete(uri).timeout(const Duration(seconds: 30));
      return processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          'API Not Responding in Time', uri.toString());
    }
  }

  Future<dynamic> putMethodParems(String api, queryParameters, body) async {
    var uri = Uri.https(API.host, api, queryParameters);

    log(uri.toString());

    try {
      var response =
          await http.put(uri, body: body).timeout(const Duration(seconds: 30));

      // return processResponse(response);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          'API Not Responding in Time', uri.toString());
    }
  }

  dynamic processResponse(http.Response response) {
    return response;
    // switch (response.statusCode) {
    //   case 200:
    //     var responseJson = utf8.decode(response.bodyBytes);
    //     //print(responseJson);
    //     return responseJson;
    //     break;
    //   case 400:
    //     throw BadRequestException(
    //         utf8.decode(response.bodyBytes), response.request.url.toString());
    //   case 404:
    //     return null;
    //   case 401:
    //   case 403:
    //     throw UnAuthorizedException(
    //         utf8.decode(response.bodyBytes), response.request.url.toString());
    //   case 500:
    //   default:
    //     throw FetchDataException(
    //         'Error occured with with code:${response.statusCode}',
    //         response.request.url.toString());
    // }
  }
}
