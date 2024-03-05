import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../domain/models/api_response.dart';
import 'package:http/http.dart' as http;

class NetworkService {

  Future<APIResponse<String>> makeStringGetRequest(Map<String, dynamic> body,
      String url) async {
    //check for network connectivity
    bool isconnected = await checkInternetConnectivity();
    Uri uri = Uri.parse(url);

    if (isconnected) {

      return http.get(uri, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',

      },).timeout(const Duration(seconds: 30), onTimeout: () {
        return http.Response('Network Time Out', 500);
      }).then((data) {
        final jsonData = jsonDecode(data.body);
        debugPrint(jsonData.toString());
        if (data.statusCode == 200) {
          return APIResponse<String>(data.body, "", false);
        } else if (data.statusCode == 400) {
          return APIResponse<String>("", "Something wrong happened", true);
        } else if (data.statusCode == 402) {
          return APIResponse<String>("", "Validation Error", true);
        }
        else if (data.statusCode == 401) {
          return APIResponse<String>("", "Authentication Error", true);
        } else {
          return APIResponse<String>("", "An error occurred", true);
        }
      }).catchError((error) {
        return APIResponse<String>("", "An error occurred", true);
      });
    } else {
      return APIResponse<String>("", "Check your connection", true);
    }
  }


  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
