// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/util.dart';

class HomeworkDetailedPage extends StatefulWidget {
  final Map? homework;

  const HomeworkDetailedPage({super.key, this.homework});

  @override
  State<HomeworkDetailedPage> createState() => _HomeworkDetailedPageState();
}

class _HomeworkDetailedPageState extends State<HomeworkDetailedPage> {
  late final Map item;

  @override
  void initState() {
    super.initState();

    final homework = widget.homework;
    if (homework != null) {
      setState(() {
        item = homework;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${item['lessonName']}'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'До какого числа сделать:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 25),
              Text(
                getDate(item['date']),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 25),
              Divider(
                color: Colors.white,
              ),
              SizedBox(height: 25),
              Text(
                'Что сделать:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 25),
              Text(
                item['task'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 25),
              Divider(
                color: Colors.white,
              ),
              SizedBox(height: 25),
              IconButton(
                icon:
                    item['isComplete'] ? Icon(Icons.check) : Icon(Icons.cancel),
                iconSize: 50,
                color: item['isComplete'] ? Colors.green[200] : Colors.red[200],
                tooltip: 'Домашняя работа зачтена!',
                onPressed: () {},
              ),
              Text(
                item['isComplete']
                    ? 'Домашняя работа зачтена!'
                    : 'Домашняя работа не зачтена!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
