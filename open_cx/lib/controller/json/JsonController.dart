import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../constants/Utility.dart' as Utility;
import 'dart:convert';

class JsonController {
  static final JsonController _jsonController = JsonController._internal();

  factory JsonController() {
    return _jsonController;
  }

  JsonController._internal();

  Future<Map<String, dynamic>> parseJsonFromURL(String url) async {
    Map<String, dynamic> _json;


    var match = new RegExp(Utility.urlPattern, caseSensitive: false).firstMatch(url);

    if(match != null) { // if url is valid
         // check if there is internet connection
      try {
        await InternetAddress.lookup('google.com');
      } on SocketException catch (_) {
        return null;
      }

      http.Client client;
      http.Response response;

      try {
        client = http.Client();
        response = await client.get(url);
      } catch (e) {
        print(e);
      }

      _json = jsonDecode(response.body);
    }
    else { // if json file is local
      _json = jsonDecode(await rootBundle.loadString(url));
    }

    return _json;
  }

}