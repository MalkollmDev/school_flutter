// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_flutter/models/user.dart';
import 'package:school_flutter/screens/homework_page.dart';
import 'package:school_flutter/services/schedule_service.dart';
import '../utils/snackbar_helper.dart';
import '../widget/schedule_card.dart';

class ScheduleListPage extends StatefulWidget {
  final UserModel? user;

  const ScheduleListPage({super.key, this.user});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  List items = [];
  late final UserModel? user;

  @override
  void initState() {
    super.initState();

    user = widget.user;

    if (user != null) {
      print(user!.groupId);

      // setState(() {
      //   user = filtered;
      // });

      getScheduleList(user!.groupId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final item = items[index] as Map;
          return ScheduleCard(
            index: index,
            item: item,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => navigateToUsersHomeworkPage(user!),
          label: Text('Домашние')),
    );
  }

  Future<void> getScheduleList(int groupId) async {
    final response = await ScheduleService.getScheduleList(groupId);
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Пока расписания занятий нет');
    }
  }

  Future<void> navigateToUsersHomeworkPage(UserModel user) async {
    final route = MaterialPageRoute(
      builder: (context) => HomeworkPage(user : user),
    );
    await Navigator.push(context, route);
  }
}
