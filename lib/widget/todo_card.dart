// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateEdit;
  final Function(int) deleteById;
  const TodoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigateEdit,
    required this.deleteById,
  });

  @override
  Widget build(BuildContext context) {
    final id = item['id'];
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['lessonName']),
        subtitle: Text(item['task']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              //edit
              navigateEdit(item);
            } else if (value == 'delete') {
              //delete
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'edit',
                child: Text('Редактировать'),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text('Удалить'),
              ),
            ];
          },
        ),
      ),
    );
  }
}
