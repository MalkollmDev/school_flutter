// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_flutter/services/schedule_service.dart';

import '../utils/snackbar_helper.dart';
import '../widget/schedule_card.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({super.key});

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  List items = [];

  @override
  void initState() {
    super.initState();
    
    getScheduleList();
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
    );
  }

  Future<void> getScheduleList() async {
    final response = await ScheduleService.getScheduleList();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Домашних заданий нет');
    }
    // setState(() {
    //   isLoading = false;
    // });
  }

  Future<void> deleteById(int id) async {
    final isSuccess = await ScheduleService.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtered;
      });
      getScheduleList();
    } else {
      showErrorMessage(context, message: 'Ошибка удаления');
    }
  }
}