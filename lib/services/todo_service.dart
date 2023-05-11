// ignore_for_file: prefer_const_declarations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_flutter/models/group.dart';
import 'package:school_flutter/models/lesson.dart';

//API методы здесь
class TodoService {
  //homework
  static Future<bool> deleteById(int id) async {
    final url = 'http://api.malkollm.ru/homeworks/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    return response.statusCode == 200;
  }

  static Future<List?> getTodoList() async {
    final url = 'http://api.malkollm.ru/homeworks/GetHomeworkByGroup/5';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return json;
    } else {
      return null;
    }
  }

  static Future<bool> updateData(int id, Map body) async {
    final url = 'http://api.malkollm.ru/homeworks';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json', 'accept': 'text/plain'});

    return response.statusCode == 200;
  }

  static Future<bool> addData(Map body) async {
    final url = 'http://api.malkollm.ru/homeworks/addhomework';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json'
    });

    return response.statusCode == 200;
  }

  //lessons
  static Future<List<LessonModel>?> getLessonList() async {
    final url = 'http://api.malkollm.ru/lessons';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<LessonModel> lessons = List<LessonModel>.from(json.map((model) => LessonModel.fromJson(model)));

      return lessons;
    } else {
      return null;
    }
  }

  //groups
  static Future<List<GroupModel>?> getGroupList() async {
    final url = 'http://api.malkollm.ru/groups';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<GroupModel> groups = List<GroupModel>.from(json.map((model) => GroupModel.fromJson(model)));

      return groups;
    } else {
      return null;
    }
  }
}
