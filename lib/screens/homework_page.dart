// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_flutter/models/user.dart';
import 'package:school_flutter/widget/homework_card.dart';

import '../services/todo_service.dart';
import '../utils/snackbar_helper.dart';

class HomeworkPage extends StatefulWidget {
  final UserModel? user;

  const HomeworkPage({super.key, this.user});

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  List items = [];

@override
  void initState() {
    super.initState();

    final user = widget.user;
    if (user != null) {
      print(user);
      getHomeworkList(user.groupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Домашние задания'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final item = items[index] as Map;
          return HomeworkCard(
            index: index,
            item: item,
          );
        },
      ),
    );
  }

  Future<void> getHomeworkList(int groupId) async {
    final response = await TodoService.getHomeworkListById(groupId);
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Домашних заданий нет');
    }
  }
}