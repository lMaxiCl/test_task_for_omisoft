import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppData extends ChangeNotifier {
  String tokenData;
  String someData = 'Nothing Yet';
  static const String _baseURL = 'http://ualegion.com:8050';

  void getToken(String email, String password) async {
    //Логика получения токена
    const String _getTokenPath = '/api/v1/security/auth';
    try {
      final response = await http.post(_baseURL + _getTokenPath,
          headers: {'content-type': 'application/json'},
          body: json.encode({"email": email, "password": password}));

      if (response.statusCode == 201) {
        tokenData = json.decode(response.body)['token'];
        print(tokenData);
        getSomeData();
      } else
        print('Unhandled response code: ${response.statusCode} ' +
            json.decode(response.body).toString());
    } catch (e) {
      print(e);
    }
  }

  void getRidOfToken() {
    //Вроде как зачищает токен
    tokenData = null;
    notifyListeners();
  }

  void getSomeData() async {
    const String _somePath = '/api/v1/users/me';
    try {
      final response = await http.get(
        _baseURL + _somePath,
        headers: {
          'content-type': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $tokenData'
        },
      );
      if (response.statusCode == 200) {
        someData = json.decode(response.body).toString();
      } else
        print('Unhandled response code: ${response.statusCode} ' +
            json.decode(response.body).toString());
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
