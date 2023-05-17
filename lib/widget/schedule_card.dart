// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final int index;
  final Map item;
  const ScheduleCard({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['id'];
    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${item['lessonStart']}'),
            Text('${item['lessonEnd']}'),
          ],
        ),
        title: Text(item['lessonName']),
        subtitle: Text('${item['lastName']} ${item['firstName']}'),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              //edit
              // navigateEdit(item);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'edit',
                child: Text('Подробнее'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
