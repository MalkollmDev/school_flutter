// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      descriptionController.text = todo['task'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit
            ? 'Редактировать домашнее задание'
            : 'Добавить домашнее задание'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // TextField(
          //   controller: titleController,
          //   decoration: InputDecoration(hintText: 'Заголовок'),
          // ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Описание'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Отправить'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      return;
    }
    final id = todo['id'];
    final description = descriptionController.text;
    final body = {
      'id': id,
      'text': description,
      'date': '2023-05-10T03:58:03.760Z',
      'lessonId': 4,
      'groupId': 5
    };

    final url = 'http://api.malkollm.ru/homeworks';
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json', 'accept': 'text/plain'});

    if (response.statusCode == 200) {
      descriptionController.text = '';
      showSuccessMessage('Задача успешно изменена');
    } else {
      showErrorMessage('Ошибка изменения задачи');
    }
  }

  Future<void> submitData() async {
    //get the data from form
    // final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "text": description,
      "date": "2023-05-10T03:58:03.760Z",
      "lessonId": 4,
      "groupId": 5
    };

    //submit data to the server
    final url = 'http://api.malkollm.ru/homeworks/addhomework';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json'
    });

    //show success or fail message based on status
    if (response.statusCode == 200) {
      descriptionController.text = '';
      showSuccessMessage('Успешно добавлено');
    } else {
      showErrorMessage('Ошибка добавления');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
