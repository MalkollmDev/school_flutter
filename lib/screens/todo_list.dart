// ignore_for_file: prefer_const_constructors, prefer_const_declarations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_flutter/models/user.dart';
import 'package:school_flutter/screens/add_page.dart';
import 'package:school_flutter/services/todo_service.dart';
import '../utils/snackbar_helper.dart';
import '../widget/todo_card.dart';

class TodoListPage extends StatefulWidget {
  final UserModel? user;
  const TodoListPage({super.key, this.user});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    final user = widget.user;
    if(user != null) {
      print(user.middleName);
    }

    getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Домашние задания'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: getTodoList,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'Нет домашних заданий',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return TodoCard(
                  index: index,
                  item: item,
                  deleteById: deleteById,
                  navigateEdit: navigateToEditPage,                  
                );
              },
            ),
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text('Добавить')),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    getTodoList();
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    getTodoList();
  }

  Future<void> deleteById(int id) async {
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtered;
      });
      getTodoList();
    } else {
      showErrorMessage(context, message: 'Ошибка удаления');
    }
  }

  Future<void> getTodoList() async {
    final response = await TodoService.getTodoList();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Домашних заданий нет');
    }
    setState(() {
      isLoading = false;
    });
  }
}
