import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nandikrushifarmer/repo/api_exceptions.dart';

import 'api_urls.dart';

class Server {
  Future<dynamic> getMethodParams(String api) async {
    var uri = Uri.parse(api);

    try {
      return http.get(uri).timeout(Duration(seconds: 30));
    } on SocketException {
      throw FetchDataException('No Internet Connection', uri.toString());
    } on TimeoutException {
      throw APINotRespondingEXception(
          'API Not Responding in Time', uri.toString());
    }
  }

  Future<dynamic> postMethodParems(body) async {
    var uri = Uri.parse(
        "http://13.235.27.243/nkweb/index.php?route=extension/account/purpletree_multivendor/api/register");

    log(uri.toString());

    try {
      var response = await http.post(uri, body: body, headers: {
        "purpletreemultivendor":
            "uaCAWn4GahZccDpZSgAy4EGlJvsSfLFI6fQK8cVPtmhQ2pQkOSQOEY5batRtAJTR5srp8VVXAWATWXUXyKxUBmWLovygSu51YLnjxKNggudMhlQzhlJXtRVnhTk46gpdON1guB4xqppNbaLvhmtu0FF7PSvAeD5NsGKWspn075ijboGtz7QiRipAu2zWlXcEMnp8hA8etK6YDyTHpscEkOVlzvfkLpTtIqhrBxMWVDtB8MzcqPDN7lMz2KZvGhnq"
      }).timeout(const Duration(seconds: 30));

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
  }
}
