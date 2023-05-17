// ignore_for_file: prefer_const_declarations

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthService {
  static Future<UserModel?> checkUser(Map body) async {
    final url = 'http://api.malkollm.ru/Users/CheckUser';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(json);

      return user;
    } else {
      return null;
    }
  }
}

