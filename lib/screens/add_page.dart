// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_flutter/models/lesson.dart';
import 'package:school_flutter/services/todo_service.dart';
import '../utils/snackbar_helper.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key, this.todo});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  List<LessonModel> lessons = [];
  late LessonModel? lessonSelected = null;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    getLessonList();
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
          DropdownSearch<LessonModel>(
            popupProps: PopupProps.bottomSheet(
              showSearchBox: true,
              showSelectedItems: false,
            ),
            items: lessons,
            itemAsString: (item) => item.name,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Предмет",
                hintText: "Выберите предмет",
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  lessonSelected = value;
                  print(lessonSelected?.name);
                  print(lessonSelected?.id);
                });
              }
            },
            selectedItem: lessonSelected,
          ),
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
      "id": id,
      "text": description,
      "date": "2023-05-10T03:58:03.760Z",
      "lessonId": 4,
      "groupId": 5
    };
    final isSuccess = await TodoService.updateData(id, body);

    if (isSuccess) {
      descriptionController.text = '';
      showSuccessMessage(context, message: 'Задача успешно изменена');
    } else {
      showErrorMessage(context, message: 'Ошибка изменения задачи');
    }
  }

  Future<void> submitData() async {
    final isSuccess = await TodoService.addData(body);

    if (isSuccess) {
      descriptionController.text = '';
      showSuccessMessage(context, message: 'Успешно добавлено');
    } else {
      showErrorMessage(context, message: 'Ошибка добавления');
    }
  }

  Future<void> getLessonList() async {
    final response = await TodoService.getLessonList();
    if (response != null) {
      setState(() {
        lessons = response;
      });
      print(lessons);
    } else {
      showErrorMessage(context, message: 'Домашних заданий нет');
    }
  }

  Map get body {
    // final title = titleController.text;
    final description = descriptionController.text;
    return {
      "text": description,
      "date": "2023-05-10T03:58:03.760Z",
      "lessonId": 4,
      "groupId": 5
    };
  }
}
