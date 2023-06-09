// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/util.dart';

class HomeworkCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) detailPage;

  const HomeworkCard({
    super.key,
    required this.index,
    required this.item,
    required this.detailPage,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['id'];
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              item['isComplete'] 
              ? Colors.green[200] 
              : Colors.red[200],
          child: Text('${index + 1}'),
        ),
        title: Text(item['lessonName']),
        subtitle: Text('Выполнить до: ${getDate(item['date'])}'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          detailPage(item);
        },
      ),
    );
  }
}
