import 'package:flutter/material.dart';

class HomeworkDetailedPage extends StatefulWidget {
  final Map? homework;

  const HomeworkDetailedPage({super.key, this.homework});

  @override
  State<HomeworkDetailedPage> createState() => _HomeworkDetailedPageState();
}

class _HomeworkDetailedPageState extends State<HomeworkDetailedPage> {
   @override
  void initState() {
    super.initState();

    final homework = widget.homework;
    if (homework != null) {
      print(homework);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Домашние '),
      ),
    );
  }
}