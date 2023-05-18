// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomeworkCard extends StatelessWidget {
  final int index;
  final Map item;
  const HomeworkCard({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['id'];
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['lessonName']),
        subtitle: Text('Выполнить до: ${getDate(item['date'])}'),
        trailing:Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  String getDate(String item){
    const String timestamp = 'T00:00:00';

    return item.replaceFirst(timestamp, '');
  }
}
