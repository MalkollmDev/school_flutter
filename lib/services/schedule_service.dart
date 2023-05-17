// ignore_for_file: prefer_const_declarations
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleService {
  static Future<List?> getScheduleList() async {
    final url = 'http://api.malkollm.ru/lessons/GetGroupSchedule/4';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return json;
    } else {
      return null;
    }
  }
}