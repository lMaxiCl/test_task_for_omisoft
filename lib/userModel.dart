import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'constants.dart';

class User {
  Map<String, dynamic> someData = {};
  String tokenData;
  int id;
  String email;
  String firstName;
  String lastName;
  String role;
  String photoURL;

  User(
      {this.tokenData,
      this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.role,
      this.photoURL});

  //Конструктор позволяющий передать в него полученый json
  factory User.login(String token, Map<String, dynamic> info) {
    return User(
      tokenData: token,
      id: info['id'],
      email: info['email'],
      firstName: info['first_name'],
      lastName: info['last_name'],
      role: info['role'],
      photoURL: info['photo_url'],
    );
  }

  static Future<String> getTokenFromStorage(storage) async {
    String _oldToken = await storage.read(key: 'token');
    if (_oldToken != null) {
      return _oldToken;
    } else {
      return null;
    }
  }

  static dynamic getUserData(String token) async {
    final _response = await http.get(
      baseURL + getUserInfoURL,
      headers: {
        'content-type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    switch (_response.statusCode) {
      case 401:
        {
          return 'unauthorised';
        }
      case 200:
        {
          return jsonDecode(_response.body);
        }
      default:
        {
          return 'unknown';
        }
    }
  }

  static String checkEmailAndPassword(String email, String password) {
    RegExp _emailValidator = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    RegExp _passwordValidator =
        RegExp(r"(?=.*[0-9])(?=.*[a-z])[0-9a-zA-Z]{6,}");
    if (_emailValidator.hasMatch(email) &&
        _passwordValidator.hasMatch(password)) {
      return 'success';
    } else
      return 'fail';
  }

  static Future<String> getTokenViaEmailAndPassword(
      String email, String password) async {
    //Логика получения токена
    switch (checkEmailAndPassword(email, password)) {
      case 'success':
        final _response = await http.post(baseURL + getTokenURL,
            headers: {'content-type': 'application/json'},
            body: json.encode({"email": email, "password": password}));
        switch (_response.statusCode) {
          case 201:
            {
              return json.decode(_response.body)['token'];
            }
          case 400:
            {
              return 'wrong_email_or_password';
            }
          default:
            {
              return 'unhandled_error';
            }
        }
        break;
      case 'fail':
        return 'validation_error';
    }
  }
}
