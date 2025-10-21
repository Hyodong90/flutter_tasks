import 'package:flutter/material.dart';
import 'package:flutter_tasks/homepage.dart';
import 'package:flutter_tasks/main.dart';

class TodoDetailPage extends StatelessWidget {
  final ToDoEntity todo;
  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(), actions: []),
    );
  }
}
